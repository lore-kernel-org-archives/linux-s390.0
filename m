Return-Path: <SRS0=V8Ip=S3=vger.kernel.org=kvm-owner@kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 5/9] s390/cio: export hsch to modules
Date: Thu, 25 Apr 2019 11:15:55 +0200
Message-Id: <20190425091559.15490-6-cohuck@redhat.com>
In-Reply-To: <20190425091559.15490-1-cohuck@redhat.com>
References: <20190425091559.15490-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The vfio-ccw code will need this, and it matches treatment of ssch
and csch.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/ioasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
index 14d328338ce2..08eb10283b18 100644
--- a/drivers/s390/cio/ioasm.c
+++ b/drivers/s390/cio/ioasm.c
@@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
 
 	return ccode;
 }
+EXPORT_SYMBOL(hsch);
 
 static inline int __xsch(struct subchannel_id schid)
 {
-- 
2.17.2
