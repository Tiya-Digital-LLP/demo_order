import 'package:demoorder/utils/extension_classes.dart';
import 'package:demoorder/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Map<String, dynamic> _trackingData = {
    "ResponseCode": 1,
    "ResponseMsg": "Order tracking data fetched successfully.",
    "Result": {
      "order_id": "ORD-10001",
      "tracking_status": "In Transit",
      "current_location": "City Sorting Facility",
      "estimated_delivery_date": "2025-03-15",
      "tracking_history": [
        {
          "date": "2025-03-01",
          "status": "Order Placed",
          "location": "Online Store",
          "description": "Your order has been placed successfully.",
        },
        {
          "date": "2025-03-02",
          "status": "Order Confirmed",
          "location": "Warehouse A",
          "description": "Your order has been confirmed and is being prepared.",
        },
        {
          "date": "2025-03-04",
          "status": "Shipped",
          "location": "City Sorting Facility",
          "description": "Your order has been shipped out for delivery.",
        },
        {
          "date": "2025-03-06",
          "status": "In Transit",
          "location": "Highway Distribution Center",
          "description": "Your order is in transit to the next hub.",
        },
      ],
    },
    "ServerTime": "UTC",
  };

  @override
  Widget build(BuildContext context) {
    List trackingHistory = _trackingData["Result"]["tracking_history"];

    return Scaffold(
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Order Tracking',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Status',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: trackingHistory.length,
                itemBuilder: (context, index) {
                  return _buildTrackingStep(trackingHistory, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep(List trackingHistory, int index) {
    bool isLast = index == trackingHistory.length - 1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            trackingHistory[index]['status'] != "Shipped" &&
                    trackingHistory[index]['status'] != "In Transit"
                ? Icon(Icons.check_circle, color: Colors.green)
                : 24.sbw,

            if (!isLast)
              trackingHistory[index]['status'] != "Shipped" &&
                      trackingHistory[index]['status'] != "In Transit" &&
                      trackingHistory[index]['status'] != "Order Confirmed"
                  ? Container(width: 2, height: 50, color: Colors.green)
                  : SizedBox.shrink(),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trackingHistory[index]['status'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Text('Date: ${trackingHistory[index]['date']}'),
              Text('Location: ${trackingHistory[index]['location']}'),
              Text('Description: ${trackingHistory[index]['description']}'),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
