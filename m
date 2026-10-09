Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DFD46AA8C;
	Fri,  9 Oct 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556107; cv=none; b=S2DIRgtuUvGL9OjGYBS9NEti++mVr2sd8FwKaz2AGWFA21+fasr2O17sajJWD5gTB72ff5DeNolUGASjB8+o6MrApi+QYfxQaQACzmr9nRTAvdQbS4rovgyzNqo+BR8sgreVSVDQGe5XsdqYyq1YLuXtcIuasy5UgzI6mXeoQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556107; c=relaxed/simple;
	bh=tg2PGqkhsmostpBVmNWR+ZDKeCW3L/qeY1HdCM2wT6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJAR6snK5X/ZfWZlTyxkNNL3Ev66ebhw+fi3Pd3NW/NTYH2DlaNbqzfmOMT/25qwFT47xrj0z+T7DM8PY9e66X8+S6tjb4JYtgAdNMQpDfd+jqIQqYVk2x//7FbSYXt4PJiSMpSN5nLZjsF/N6QcFGfbCGSCNP+yPy7FqbCBa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QCdI+/ax; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QCdI+/ax"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DZcso090473;
	Fri, 9 Oct 2026 14:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PexWpaOtFEo3PYSUe
	+Us9vloLtsFEefLBuqSyBslCM0=; b=QCdI+/axFfXM26ppV6ThjBrPb4bxqctG0
	NT562U5vyydpypRDvASDNApvY+4glbwF4dMJU7WjQNcF+45xYp51JAZPqVtw2E5x
	gfiEVpCklQT0IMvcrXrwrgIfxG1a4xbHWOQHKkzSlNTwS2twKwKHInwzaf2rXORo
	7Snn8Y/WwMh7xnFOt3DWhcr0vNHRkLGxgkuVY8kSvReNIsvEmnXrfGoWccqdthQt
	OEeD2fpzK0Ao+5mGeVNe9RhrbJmkYuZDZjYS9U2ju3YpGNpDLHnD2gpXc4wjLCZl
	ir1P0Fwf4GhnEFYFaOes9Elkqiu4fJAp3o1SANmyKqQ3C7Q25A20A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwage4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWXAG968181;
	Fri, 9 Oct 2026 14:28:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnkbu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699ES9C360424526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:28:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBAEC58066;
	Fri,  9 Oct 2026 14:28:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C9A58059;
	Fri,  9 Oct 2026 14:28:04 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:28:04 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL 3/6] KVM: x86: Use file_to_kvm_x86() in SEV
Date: Fri,  9 Oct 2026 16:27:46 +0200
Message-ID: <20261009142749.186650-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009142749.186650-1-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX1rv1h8PTvevB
 YdxoBqrK1LfrOE1eGlR3jVxzNlA63QlzVh4/mBCH3NEMPjTgu1EEHY0OT+y+/Jovt5sExxdndo/
 4dbbCgF8gf3zsqHMVTJEor0Tye8WN9I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfXzEMlD6UZVYzs
 Xgb/Zr2H9gCGpFf3wg+66zlyhe3g+7V+54R4+/eaI7Ecu5uN5GmlDFxdfHRMejZG7TIHZWdwgD4
 E/jzZC1cdTrYcYTWlk/2UthpmGGwSv/GZiSHWUfVpIn4QN2vcqLQQh0NLgJHAW+5viQACwVC6l5
 /Ig/SBwgXOVsDhu7tTFdQFBjgMbXGihUhTH2Qi3h+f6NZkNG3hnx8Qrj0usCxrjCyYA0LoaaiGe
 PDfUFDqOEQBbnAhKsyyFuzQsI/V3pU9g9s8H96IgQu35Fyn4I2QhtqfNEKtXW42tA+4z6UCxFhm
 LGOVuhzeUWypzoEpIqQt8YkZhGugtS8cX2UWNq5suQLUD+x9/LZ7kQjrccR9Puq6QeNoy2t7R0D
 qwReMqe5+YZ86QCSVZyQCVxk7o4HWMViOH92sXV/GtNG/XRjEDPi4/Ios6toykyOgJnLkjja04Z
 fHO8Xl/WwnbEd+YBxkw==
X-Proofpoint-GUID: NpiwV7KJpOQG_RkzJAMa-LMTuUJk7uVV
X-Proofpoint-ORIG-GUID: huE6M7R-AOSHbqCIElSPOTnVrHlF06ah
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac8f9fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=JZHfIBTrcVpj99XhhAcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090056

From: Steffen Eiden <seiden@linux.ibm.com>

Use the new arch-namespaced helper instead of open-coding the file check
and private_data cast separately.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..6b0eacde4f06 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2145,10 +2145,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
@@ -2866,10 +2866,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
-- 
2.53.0

