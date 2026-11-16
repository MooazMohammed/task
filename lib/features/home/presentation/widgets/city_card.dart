import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:task/core/constants/app_models.dart';

class CityCard extends StatelessWidget {
  final CityModel city;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const CityCard({
    super.key,
    required this.city,
    this.onTap,
    this.width = 145,
    this.height = 195,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background city image with cached image loader
              CachedNetworkImage(
                imageUrl: city.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: const Color(0xFF1E293B),
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: const Color(0xFF1E293B),
                  child: const Icon(Icons.location_city, color: Colors.white38, size: 36),
                ),
              ),

              // Gradient overlay for contrast
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x33000000),
                      Color(0x4D000000),
                      Color(0xCC000000),
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
              ),

              // City Name centered in the middle of the card
              Center(
                child: Text(
                  city.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Cairo',
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Color(0x80000000),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom counts: "عقارات للبيع : 505" & "عقارات للإيجار : 1002"
              Positioned(
                bottom: 12,
                right: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'عقارات للبيع : ${city.forSaleCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                        shadows: [
                          Shadow(
                            color: Color(0x99000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'عقارات للإيجار : ${city.forRentCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                        shadows: [
                          Shadow(
                            color: Color(0x99000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
