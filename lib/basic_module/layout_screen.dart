import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  // A sample image to use for all tiles (you can change this per item later)
  final String firstImg = "https://imgs.search.brave.com/5LKxNb5SoEdwB3tNWatVYmYTkFnfVSFRTBbOU622qYE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTQz/OTM5MTc2Ni9waG90/by9hbmNpZW50LWNp/dmlsaXNhdGlvbi1j/YW1ib2RpYW4tdGVt/cGxlLWF0LXNpZW0t/cmVhcC1hbmQtdGhl/LXN1cnJvdW5kaW5n/LWNvdW50cnlzaWRl/LXRlbXBsZS5qcGc_/cz02MTJ4NjEyJnc9/MCZrPTIwJmM9SVNN/bDFrVnh3NEJmdko5/dXlucENEVUtYeFBO/aGN1QTZmVTcyQjBY/MEg0Zz0";
  final String secondImg = "https://imgs.search.brave.com/OtxAylhmJf3s5s5BrOhHSUJiZDBqPgVgt-kXjONhtL0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hc2lh/cGlvbmVlcnRyYXZl/bC5jb20vd3AtY29u/dGVudC91cGxvYWRz/LzIwMjEvMDEvRW50/ZXJpbmctaW50by10/aGUtYW5jaWVudC10/ZW1wbGUtb2YtUHJl/YWgtS2hhbi1pbi1T/aWVtLVJlYXAtQ2Ft/Ym9kaWEuLTYwMHg0/MDAuanBn";
  final String thirdImg = "https://imgs.search.brave.com/XdGCCCO6tffggaTn-BPj4UG9k5KRJlMEAbKQYSmM3yY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS53b3JsZG5vbWFk/cy5jb20vRXhwbG9y/ZS9jYW1ib2RpYS9w/cmFzYXQtcHJlYWgt/dmloZWFyLWNhc3Np/ZXdpbGtpbnMuanBn";
  final String forthImg = "https://imgs.search.brave.com/wTSByg5QPw3jMOWL2yqt7G7GRv4usP-vBk_T8m-z53w/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dHJhdmVsbG9jYWwu/Y29tL19uZXh0L2lt/YWdlP3VybD1odHRw/czovL3Jlc291cmNl/cy50cmF2ZWxsb2Nh/bC5jb20vd3AvdXBs/b2Fkcy8yMDIzLzEw/LzAzMTQwMTUzL3No/dXR0ZXJzdG9ja184/OTE0MDQzMi1zY2Fs/ZWQuanBnJnc9Mzg0/MCZxPTc1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Layout Screen")),
      body: _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      physics: const BouncingScrollPhysics(),
      childAspectRatio: 2 / 3, // Tall rectangle
      padding: const EdgeInsets.all(8),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        _buildImageTile(firstImg),
        _buildImageTile(secondImg),
        _buildImageTile(thirdImg),
        _buildImageTile(forthImg),
        _buildImageTile(firstImg),
        _buildImageTile(secondImg),
        _buildImageTile(thirdImg),
        _buildImageTile(forthImg),
        _buildImageTile(firstImg),
        _buildImageTile(secondImg),
        _buildImageTile(thirdImg),
        _buildImageTile(forthImg),
      ],
    );
  }

  // --- The Helper Function ---
  Widget _buildImageTile(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
        color: Colors.grey[300], // Loading/Fallback color
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover, // Crucial: Makes image fill the 2/3 shape
        ),
      ),
    );
  }
}