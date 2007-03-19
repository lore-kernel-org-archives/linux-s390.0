Return-Path: <linux-kernel-owner+w=401wt.eu-S933874AbXCSNBa@vger.kernel.org>
Date: Mon, 19 Mar 2007 14:01:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] zcrypt: fix possible race when unloading zcrypt driver modules
Message-ID: <20070319130139.GB1292@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: rwuerthn@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[S390] zcrypt: fix possible race when unloading zcrypt driver modules

Move try_module_get() call into spin protected block to prevent zcrypt
driver module unload while submitting a request to driver.

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_api.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_api.c linux-2.6-patched/drivers/s390/crypto/zcrypt_api.c
--- linux-2.6/drivers/s390/crypto/zcrypt_api.c	2007-03-19 13:09:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_api.c	2007-03-19 13:09:27.000000000 +0100
@@ -298,14 +298,14 @@ static long zcrypt_rsa_modexpo(struct ic
 		get_device(&zdev->ap_dev->device);
 		zdev->request_count++;
 		__zcrypt_decrease_preference(zdev);
-		spin_unlock_bh(&zcrypt_device_lock);
 		if (try_module_get(zdev->ap_dev->drv->driver.owner)) {
+			spin_unlock_bh(&zcrypt_device_lock);
 			rc = zdev->ops->rsa_modexpo(zdev, mex);
+			spin_lock_bh(&zcrypt_device_lock);
 			module_put(zdev->ap_dev->drv->driver.owner);
 		}
 		else
 			rc = -EAGAIN;
-		spin_lock_bh(&zcrypt_device_lock);
 		zdev->request_count--;
 		__zcrypt_increase_preference(zdev);
 		put_device(&zdev->ap_dev->device);
@@ -373,14 +373,14 @@ static long zcrypt_rsa_crt(struct ica_rs
 		get_device(&zdev->ap_dev->device);
 		zdev->request_count++;
 		__zcrypt_decrease_preference(zdev);
-		spin_unlock_bh(&zcrypt_device_lock);
 		if (try_module_get(zdev->ap_dev->drv->driver.owner)) {
+			spin_unlock_bh(&zcrypt_device_lock);
 			rc = zdev->ops->rsa_modexpo_crt(zdev, crt);
+			spin_lock_bh(&zcrypt_device_lock);
 			module_put(zdev->ap_dev->drv->driver.owner);
 		}
 		else
 			rc = -EAGAIN;
-		spin_lock_bh(&zcrypt_device_lock);
 		zdev->request_count--;
 		__zcrypt_increase_preference(zdev);
 		put_device(&zdev->ap_dev->device);
@@ -408,14 +408,14 @@ static long zcrypt_send_cprb(struct ica_
 		get_device(&zdev->ap_dev->device);
 		zdev->request_count++;
 		__zcrypt_decrease_preference(zdev);
-		spin_unlock_bh(&zcrypt_device_lock);
 		if (try_module_get(zdev->ap_dev->drv->driver.owner)) {
+			spin_unlock_bh(&zcrypt_device_lock);
 			rc = zdev->ops->send_cprb(zdev, xcRB);
+			spin_lock_bh(&zcrypt_device_lock);
 			module_put(zdev->ap_dev->drv->driver.owner);
 		}
 		else
 			rc = -EAGAIN;
-		spin_lock_bh(&zcrypt_device_lock);
 		zdev->request_count--;
 		__zcrypt_increase_preference(zdev);
 		put_device(&zdev->ap_dev->device);
