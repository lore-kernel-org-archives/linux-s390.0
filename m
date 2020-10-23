Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v3 05/56] s390: fix kernel-doc markups
Date: Fri, 23 Oct 2020 18:32:52 +0200
Message-Id: <c4bf95fbd9c33a92eb60ef3d696d4cbe27882079.1603469755.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
List-ID: <linux-s390.vger.kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Alexander Egorenkov <egorenar@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

fix one typo:
	ccw driver -> ccw_driver

and one function rename.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/s390/include/asm/ccwdev.h | 2 +-
 arch/s390/include/asm/cio.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index c0be5fe1ddba..069709b8e9e7 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -115,7 +115,7 @@ enum uc_todo {
 };
 
 /**
- * struct ccw driver - device driver for channel attached devices
+ * struct ccw_driver - device driver for channel attached devices
  * @ids: ids supported by this driver
  * @probe: function called on probe
  * @remove: function called on remove
diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 5c58756d6476..23dceb8d0453 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -329,7 +329,7 @@ struct ccw_dev_id {
 };
 
 /**
- * ccw_device_id_is_equal() - compare two ccw_dev_ids
+ * ccw_dev_id_is_equal() - compare two ccw_dev_ids
  * @dev_id1: a ccw_dev_id
  * @dev_id2: another ccw_dev_id
  * Returns:
-- 
2.26.2
