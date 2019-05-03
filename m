Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 4/7] s390/cio: Initialize the host addresses in pfn_array
Date: Fri,  3 May 2019 15:49:09 +0200
In-Reply-To: <20190503134912.39756-1-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
Message-Id: <20190503134912.39756-5-farman@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Let's initialize the host address to something that is invalid,
rather than letting it default to zero.  This just makes it easier
to notice when a pin operation has failed or been skipped.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index b70306c06150..43c6d1cf1653 100644
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
2.16.4
