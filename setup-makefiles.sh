#!/bin/sh

VENDOR=acer
DEVICE=picasso

OUTD=vendor/$VENDOR/$DEVICE
BLOBMK=../../../$OUTD/$DEVICE-vendor-blobs.mk
VENDORMK=../../../$OUTD/$DEVICE-vendor.mk
BOARDMK=../../../$OUTD/BoardConfigVendor.mk

for i in $BLOBMK $VENDORMK $BOARDMK; do
cat << EOF > $i
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

EOF
done

echo 'PRODUCT_COPY_FILES += \' >> $BLOBMK
while read line; do
    echo "    $OUTD/proprietary/$line:/system/$line \\" >> $BLOBMK
done < proprietary-files.txt

cat << EOF >> $VENDORMK
# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS := $OUTD/overlay

\$(call inherit-product, $OUTD/$DEVICE-vendor-blobs.mk)
EOF

echo "USE_CAMERA_STUB := false" >> $BOARDMK
