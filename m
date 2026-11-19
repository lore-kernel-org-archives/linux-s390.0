Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092588;
	b=tsWsK2FyJNR7G2+b83JE0XvNWoIYVv+kkN3ZOBdWDq96176rq603NgsU15N4nY58CCZ7
	 DS2mTbhA43SM7OC0tNoE2fuyBBP4m3BGfti0xYYCvU7ykTGunl5zhbOW6TPfFl2k77YDy
	 88pGgr8EXD+oqr33DXJPJpW76PGzKvCKOtoD82Z9Wm8DknUNzdzP64+5o2VwMtiuNqh2D
	 FZlGQaL+hT9eJqRMKHDEecEsiN7hgjwcdN5AvZ0JEWck+4SdhFLoaXOMRKhjaEKBBEvPm
	 FTMDJd7Bkf9PMNFGD3CVPMrO5yk3N51uhzpP/I4AFq4zISHVzIAp0suzC+GAhX7w64A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092588;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=800+SIE4rgCJAMg014EOnxWt6ztqO5cVv4AmjMiQFXI=;
	b=uJ0wJ2OWQERI9m+ud6I2c08IB8NdpH0i+rUczg2TOXFG6Dvn2/BQ3ldHBc4SiRhJRNgp
	 xIHzTzba3/j628859GbSejEE74qhamLHyENq6+bcOUZECGEYzaQfiN62cCIzry7gevd+x
	 t8bwAPFRlXmYo7Yn62WPqeYizJ0IDN3BeDYBPtFVPxUH0hXAi9Ae3+HC2u1U7I70jWgrd
	 ed5Y8S3/5KosCbv97CrRbgf2LH92PbstMMhuqZq+920fn1ibL2hizPB6na9lOVBs5dBtA
	 sbs7Lcw0fnbTj2n5uAFI4HsAOvsPwIHe5PyLVbnlFILT3WivnGclBRKa+5EO4J/zkcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kr1LzG2F;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C38606A338;
	Thu, 19 Nov 2026 12:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C38606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kr1LzG2F
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBu7bF037184;
	Thu, 19 Nov 2026 12:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=800+SIE4rgCJAMg01
	4EOnxWt6ztqO5cVv4AmjMiQFXI=; b=Kr1LzG2F8ZgQ1a+8rcXdTwImEJgKQVuie
	AkFPS4CvjvsHhjGl3aBM4/l1rc6LaVNk/KnkBhSkM4hi/y56yRS6C6lGJm3IZgk1
	5VFZNaDg3VmvRz9jltjxj3BFsbFxRsLcgxd4k2hevQUJGwtFZe+p9eqrQlLEaQ4N
	+6DjAoRLnkDG9OxXoozUf7e9vR2ue9xB5tuUT7fauJ3qWtGmMO5vXENVQEo53uYf
	Dt/k5xrbv/x9Z99rAyO1VhdlOW3fAJnj9CdMi4mORS+6CiTmwSyJ3vHrtdpb11Ji
	Qi9MEMpNi2LmPxfCj18XdqfRTv4LfUfuQ8vZzylHl0b0bhYAhWimg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nh2rf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:49:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBnweY812697;
	Thu, 19 Nov 2026 12:49:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6vbjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:49:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJCng8b19071492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 12:49:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A1A58067;
	Thu, 19 Nov 2026 12:49:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE36E58056;
	Thu, 19 Nov 2026 12:49:39 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 12:49:39 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, pbonzini@redhat.com,
        seanjc@google.com, shuah@kernel.org, ggala@linux.ibm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] KVM: s390: vsie: Do not overwrite guest 3 state on early validity icpt
Date: Thu, 19 Nov 2026 13:49:35 +0100
Message-ID: <20261119124936.33396-2-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119124936.33396-1-ggala@linux.ibm.com>
References: <20261119124936.33396-1-ggala@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX6HzCfua8b19g
 VG0QX4MLCoLPHrLlAK6qtBxJaPQ6dhSGXTooDQ1EZMkz/OTgwXQ00WXZXSMD0M33kr0EwawypWq
 PTIRLGQ1EWbzNrwWKMMGzU3p57HgLQ8u97h5zPbFyBOxizh0hY/BgnZnMIqvJxMJkNaKD/tRX6S
 EV56Rwx+j7k5fzpGIxf77Z08yx9NWKopew2W/+BihpEGl6Ep9IZNJpePM7/Jh1v21DEoSdF9PqX
 U+aGiFJ3mCOVCJ1j/MVz8N4Gnf2JgLldBojER9/dbH8krEBOvNvx84GmufVTGsqPh4qKBIfhSjE
 Ico1/oSIA3GjrfVEK5bEAmEqu3URqJhQvsksSVmJDyiHWpfoJ5ppxOcOd1V80lC2KPdMwekG/MT
 RS+jL5ZAJwxSBY0HvMX3b3Q9fyrIp6el5pKcZl+inAhfSYH3L/v+fVp+4PbLk9PoiYkvAaoKopk
 CEkcAJmTk3/xiUFmuDA==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afef069 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HnRTBInXDna0ns452sMA:9
X-Proofpoint-GUID: wOGk5yA8M8eeT2P6DBJ82EYurPRnC80P
X-Proofpoint-ORIG-GUID: oPep0NYo2hkbU3yzTuogdTxeAU0A62dg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX+YzbTO00LHJJ
 QlSL54aSobp19aqjcNvtLvpIDV1uGSRINpCuHQyhiLfmgiMYFcmRD1TyN9TPRqbU8+9j6zao90E
 XHUhp5LPsWoBGec76h/IXceFl6AT/Fo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190049

shadow_scb() calls prepare_cpuflags() first, which can reject the SCB
provided by guest 2 with a validity interception. This happens before
the guest state (gpsw, gg14, gg15, gcr, cputm, ckc, todpr, pp) and the
control fields (gbea, fpf) are copied from the original SCB into the
shadow SCB.

The error path still calls unshadow_scb(), which copies that state from
the shadow SCB back into the original one. The shadow SCB does not hold
guest 3 state at this point:

 - For a new or recycled vsie page, get_vsie_page() has cleared the
   shadow SCB, so the guest 3 state in the guest 2 SCB is overwritten
   with zeroes.
 - For a cached vsie page that is looked up again by SCB address, the
   shadow SCB still holds the state from the end of the previous run,
   so the current guest 3 state is replaced by the old one.

No guest 3 instruction ran, yet guest 2 sees its guest 3 state (PSW,
GRs, CRs, timers) modified. unshadow_scb() also clears FPF_BPBC if
facility 82 is available, because fpf was cleared in the shadow SCB
just before, and copies back a stale ihcpu.

The SCB and the validity condition are controlled by guest 2, so this
is a correctness problem for guest 2 only and does not cross a guest or
host boundary.

Only the interception data needs to be passed on in this case. Add
unshadow_icpt() for that and use it from unshadow_scb() and from the
prepare_cpuflags() failure path, which now returns directly. The other
failure paths of shadow_scb() are reached after the guest state has
been copied and keep using unshadow_scb().

On a cached vsie page, the interception data in the shadow SCB still
holds the values of the previous run. set_validity_icpt() writes ipa,
ipb and icptcode, but not icptstatus, so a stale icptstatus would be
passed on together with the new validity interception. Also, it is not
defined what SIE stores in icptstatus, ipa and ipb when it exits without
an interception, so they must not be relied upon to be zero or unchanged.
Clear them together with icptcode when the shadow SCB is reused,
so that no stale interception data is passed on to guest 2.

Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5926689fa226..1f618bb274a8 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -424,6 +424,15 @@ static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	}
 }
 
+static void unshadow_icpt(struct kvm_s390_sie_block *scb_o,
+			  struct kvm_s390_sie_block *scb_s)
+{
+	scb_o->icptcode = scb_s->icptcode;
+	scb_o->icptstatus = scb_s->icptstatus;
+	scb_o->ipa = scb_s->ipa;
+	scb_o->ipb = scb_s->ipb;
+}
+
 /* unshadow the scb, copying parameters back to the real scb */
 static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
@@ -431,10 +440,7 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 
 	/* interception */
-	scb_o->icptcode = scb_s->icptcode;
-	scb_o->icptstatus = scb_s->icptstatus;
-	scb_o->ipa = scb_s->ipa;
-	scb_o->ipb = scb_s->ipb;
+	unshadow_icpt(scb_o, scb_s);
 	scb_o->gbea = scb_s->gbea;
 
 	/* timer */
@@ -490,6 +496,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	/* make sure we don't have any leftovers when reusing the scb */
 	scb_s->icptcode = 0;
+	scb_s->icptstatus = 0;
+	scb_s->ipa = 0;
+	scb_s->ipb = 0;
 	scb_s->eca = 0;
 	scb_s->ecb = 0;
 	scb_s->ecb2 = 0;
@@ -499,8 +508,10 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->fpf = 0;
 
 	rc = prepare_cpuflags(vcpu, vsie_page);
-	if (rc)
-		goto out;
+	if (rc) {
+		unshadow_icpt(scb_o, scb_s);
+		return rc;
+	}
 
 	/* timer */
 	scb_s->cputm = scb_o->cputm;
@@ -614,7 +625,6 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
-out:
 	if (rc)
 		unshadow_scb(vcpu, vsie_page);
 	return rc;
-- 
2.56.0

