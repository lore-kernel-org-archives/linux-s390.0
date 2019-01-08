From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function process_gib_alert_list()
Date: Tue, 8 Jan 2019 07:37:57 +0100
Message-ID: <20190108063757.GA3766@osiris>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-14-mimu@linux.ibm.com>
 <645d74cf-7448-f143-c899-bdcf290dac59@linux.ibm.com>
 <ae479e60-d235-acf3-55cc-afd875644a19@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae479e60-d235-acf3-55cc-afd875644a19@linux.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com
Cc: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 07, 2019 at 08:19:26PM +0100, Michael Mueller wrote:
>=20
> On 03.01.19 15:43, Pierre Morel wrote:
> >On 19/12/2018 20:17, Michael Mueller wrote:
> >>This function processes the Gib Alert List (GAL). It is required
> >>to run when either a gib alert interruption has been received or
> >>a gisa that is in the alert list is cleared or dropped.
> >>
> >>The GAL is build up by millicode, when the respective ISC bit is
> >>set in the Interruption Alert Mask (IAM) and an interruption of
> >>that class is observed.
> >>
> >>Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >>---
> >>=A0 arch/s390/kvm/interrupt.c | 140
> >>++++++++++++++++++++++++++++++++++++++++++++++
> >>=A0 1 file changed, 140 insertions(+)
> >>
> >>diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> >>index 48a93f5e5333..03e7ba4f215a 100644
> >>--- a/arch/s390/kvm/interrupt.c
> >>+++ b/arch/s390/kvm/interrupt.c
> >>@@ -2941,6 +2941,146 @@ int kvm_s390_get_irq_state(struct kvm_vcpu
> >>*vcpu, __u8 __user *buf, int len)
> >>=A0=A0=A0=A0=A0 return n;
> >>=A0 }
> >>=A0 +static int __try_airqs_kick(struct kvm *kvm, u8 ipm)
> >
> >static inline ?

Why?

In general it is a good idea to leave it up to the compiler to decide
if it is worth to inline a function or not, unless you have a good
reason to force inlining.
