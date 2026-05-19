Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880D3769FE;
	Tue, 19 May 2026 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202889; cv=none; b=D12pJlHiQmSrMFlMmzzRpzs6aYrwrWDq7lUyI93XOcTkOKp8vwpew6FkueWpk4pTJ0wtv4DwDA/gvMVqSSmT42Pk7PPLjNrl2K7+lNL7etFm8VdFH2uXoEkIBPSPZehWQkW1pwc1l1OrlXIJQzqnuGrJ7g+9hwQWziRYv9bpPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202889; c=relaxed/simple;
	bh=IxQztV6GbjkUo7AEeaEUb45NEurD3Pn4LXilsRDGhJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYBCU20gt/UCNcBNgNE7Tywc29alE+F/Oonc/MWJsJlzQ3L11kWkFvIpsfbswUMPsQV93XZNpy5H/SsZIiOl7ETZ7oLaUru7wX9wS+ilvm84BqCu5nqJ9NFYOFP1RIm4iTqytHr0pla/WvrP/9TSLRXOtGWZ3tVr0PRs03wmvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fLeSRMiJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fLeSRMiJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8oBwZ789447;
	Tue, 19 May 2026 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WO5FPexyVAPQ+TY5zMai3jpdMTTcMXGPOD4Ts7/W0
	/Q=; b=fLeSRMiJO9lS4m34zJOxOSJDZQNr8qHDDBcM6VWKWi8G73DeGZ+Se0JFh
	MLl6/vyizFuQz0PyDpw+ABn1xmmuGJ3ksPaJCFnH31rc9dEeDUybNe92u2oprFhe
	bH6n4718IZOolvNjupUmieqFlm9dW5yq/HnTwKEczvQwFyhw4nHGqs5KVJKKmuDs
	yCLICljs9dtV3MU/Tatg2+BiQbQmB2cv9qxKMLM5i34maCK7ArsUZ0OIzB30GdUu
	wdtddsQuuRpXRaUsuIktvOQR30drsVeOiuxQShM4Xqch6vob5P8ly5bS+FjM/dH6
	K5aIbzIJZLKcBgSnujRFJFVyYubAA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8cvn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JEs5v8008026;
	Tue, 19 May 2026 15:01:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk35nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JF1F8j30999186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:01:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76A322004F;
	Tue, 19 May 2026 15:01:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EDE720040;
	Tue, 19 May 2026 15:01:14 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:01:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 0/5] KVM: s390: some vSIE and UCONTROL fixes
Date: Tue, 19 May 2026 17:01:09 +0200
Message-ID: <20260519150114.264309-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0NSBTYWx0ZWRfXyQ352Xm4Dej0
 QRSEALeSpBmwVvqtYtbI9apxJZF0d6mBSSp9cxrTR4dG8sCEp6ix27wkuES6KZO6SCunLoFxFNG
 JaKlprEU3yjTD2oLo7ColK2nISE0Me0mAoHWKpz+0XwW+dlCKHUhWyZGBD3zOVYmfOtaEtmAjQt
 ZDS5fnOklMF4Kvp+FarLrifqxU7meI6VzVsyH6PXNiACbE9hUGhEzYVaWrQDM0hHMPubV0bjTpY
 HXbdflk42oFI7tr/Fb7X9BNnEfc9p2bI9kdNkQPIAXqUpynRShXk3bChz+dfeTjxup7hKQcCLIV
 0l/205D72abw/gliW+cefuB9znnlP56Zj8Lj2q6nTH87ik+o4nyo80CVtj3Ab50wWdV/SEbYXXT
 7N/C+eYNgQFVL4eXHlcKn7w5J9SLMQ+LtR5qsG/+vh9uodHwK007bxucvFUeqed1fVlCppr6NU4
 f1tMJD3wNdW4MVikgdg==
X-Proofpoint-GUID: LtIWuTlgx09q6sy7Vdax1NZ92_N9OZLG
X-Proofpoint-ORIG-GUID: LtIWuTlgx09q6sy7Vdax1NZ92_N9OZLG
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0c7b43 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=WLamS9KfzQc7_2FcH0gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190145

Fix some memory issues and some hangs in vSIE.

This is still a fallout from the gmap rewrite.

v2->v3:
* Add comments to pte_needs_unshadow() and crste_needs_unshadow()
  explaining how they work
* Improve some patch descriptions

v1->v2:
* Fix potential leak of struct kvm_s390_mmu_cache in gmap_set_limit()
* Refactor and improve the checks to determine whether an unshadowing
  is needed
* Set and propagate vsie_gmem properly
* Properly mask the address passed to gmap_insert_rmap() to prevent
  creating multiple redundant rmaps when shadowing
* Clear the pgste.zero flag when needed, to prevent pages from getting
  accidentally discarded

Claudio Imbrenda (5):
  KVM: s390: vsie: Fix memory leak when unshadowing
  KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
  KVM: s390: vsie: Fix unshadowing logic
  KVM: s390: vsie: Fix redundant rmap entries
  KVM: s390: Properly reset zero bit in PGSTE

 arch/s390/kvm/dat.c     |  1 +
 arch/s390/kvm/dat.h     |  3 +-
 arch/s390/kvm/gaccess.c |  1 +
 arch/s390/kvm/gmap.c    | 18 +++++++-----
 arch/s390/kvm/gmap.h    | 61 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.54.0

