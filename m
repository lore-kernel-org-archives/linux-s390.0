From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 16:12:00 +0000
Subject: [CRIU][PATCH 2/7] criu/pie/parasite-vdso: Handle also systems without VVAR
Message-Id: <20170628161205.37787-3-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On s390 we don't use vvar. Therefore vvar_size in not been initialized
and the value remains VVAR_BAD_SIZE.

Fix the BUG() statement to also cover this case.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/pie/parasite-vdso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/criu/pie/parasite-vdso.c b/criu/pie/parasite-vdso.c
index 40b2695..ad178e9 100644
--- a/criu/pie/parasite-vdso.c
+++ b/criu/pie/parasite-vdso.c
@@ -44,9 +44,11 @@ static int vdso_remap(char *who, unsigned long from, unsigned long to, size_t si
 /* Park runtime vDSO in some safe place where it can be accessible from restorer */
 int vdso_do_park(struct vdso_maps *rt, unsigned long park_at, unsigned long park_size)
 {
+	unsigned long vvar_size;
 	int ret;
 
-	BUG_ON((rt->sym.vdso_size + rt->sym.vvar_size) < park_size);
+	vvar_size = (rt->sym.vvar_size == VVAR_BAD_SIZE) ? 0 : rt->sym.vvar_size;
+	BUG_ON((rt->sym.vdso_size + vvar_size) < park_size);
 
 	if (rt->vvar_start != VVAR_BAD_ADDR) {
 		if (rt->sym.vdso_before_vvar) {
-- 
2.7.4
