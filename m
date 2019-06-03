Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 4/7] s390/cio: Initialize the host addresses in pfn_array
Date: Mon,  3 Jun 2019 12:50:35 +0200
Message-Id: <20190603105038.11788-5-cohuck@redhat.com>
In-Reply-To: <20190603105038.11788-1-cohuck@redhat.com>
References: <20190603105038.11788-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

Let's initialize the host address to something that is invalid,
rather than letting it default to zero.  This just makes it easier
to notice when a pin operation has failed or been skipped.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190514234248.36203-5-farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index e33265fb80b0..086faf2dacd3 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -91,8 +91,11 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
 	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
 
 	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
-	for (i = 1; i < pa->pa_nr; i++)
+	pa->pa_pfn[0] = -1ULL;
+	for (i = 1; i < pa->pa_nr; i++) {
 		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
+		pa->pa_pfn[i] = -1ULL;
+	}
 
 	return 0;
 }
-- 
2.20.1
