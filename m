Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 4/5] KVM: s390: vsie: Move conditional reschedule
Date: Thu,  2 Apr 2020 20:48:18 +0200
Message-Id: <20200402184819.34215-5-david@redhat.com>
In-Reply-To: <20200402184819.34215-1-david@redhat.com>
References: <20200402184819.34215-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

Let's move it to the outer loop, in case we ever run again into long
loops, trying to map the prefix. While at it, convert it to cond_resched(=
).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4f6c22d72072..ef05b4e167fb 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1000,8 +1000,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struc=
t vsie_page *vsie_page)
=20
 	handle_last_fault(vcpu, vsie_page);
=20
-	if (need_resched())
-		schedule();
 	if (test_cpu_flag(CIF_MCCK_PENDING))
 		s390_handle_mcck();
=20
@@ -1185,6 +1183,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
 		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
 		    kvm_s390_vcpu_sie_inhibited(vcpu))
 			break;
+		cond_resched();
 	}
=20
 	if (rc =3D=3D -EFAULT) {
--=20
2.25.1
