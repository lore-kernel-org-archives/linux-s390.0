Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CE30CDAF;
	Wed,  1 Apr 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009371; cv=none; b=jtETe1HynOJY5cFPVKtkEfrC8+CXXFS47QyAV4f6qLPOVFPn0vLZdWyPAWietlY2ZmVJBhgTtjLIMTvtE5C0094CIfdmt1MeQr97bfUdfmM/a+T/ynncow3ZaPUzJGXtxjNQxKx97i0ntwKJcxXUB6HdqLDxt/854c/zoTfnAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009371; c=relaxed/simple;
	bh=psIRMteHiJbC6Ibui6pnmJfDUgrll//vglx8JBkoH+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8m4grOTdJpFQNnf/GI0BYDz9nNvzMiqN2S1ERqdLIXkaL1/KjfYZ6T+fXMSim2i0wwWaPYKUMGXTUiQGocEkLHrKrJvwNpxAkUzpaLbBk75+U2OiY2w9y6j9M9k/EhugiNLyw//d2K0Y7sluUIXLQuhpnJXL0lj1aOloDFlcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lUnYcSwI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lUnYcSwI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VJRrnh197973;
	Wed, 1 Apr 2026 02:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pwcSQ8ac56LBoTm2Udms8o6C054OUpZ09rNqzc1AC
	48=; b=lUnYcSwIJSuCZTGmmIINLdfFX+HPt3Qcp1UJSHHhnItJe5b6OCJEyXLFC
	wI1NNN72F9+JoCqwNBX/w/NE7dIYK1XXmt2DPL5lUtdBJ8gDiIz31HFTBU8QaUPw
	2cY+HL5OoozLqbsbRYGw8eok1TgQM0t5jSjI6ixVHs90iW4cl6CFMTaqxCDWVyxv
	hDMN8b4xtDNjThXRiscIDKuyEO2IR1U7Xj8jU2EYorOPKRydH3apC66+gC97xqH8
	KsY/ckA84ZTmVBG6Hd8AVObYYZmw7NGnkTDk9cegU3jgEZ4z+dtgrMI67uEhfPy7
	DGB/AaaRDV5RUHFT/ADuYYz86r9KA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgnq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6310w2t7022291;
	Wed, 1 Apr 2026 02:09:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan3qjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63129HZO47120644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 02:09:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0D92004B;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A9E620040;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 7C95FE0ADF; Wed, 01 Apr 2026 04:09:17 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 0/4] KVM: s390: Permit ESA mode guests in VSIE
Date: Wed,  1 Apr 2026 04:09:11 +0200
Message-ID: <20260401020915.1339228-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxMCBTYWx0ZWRfX52wlAmEuscaa
 zEjsqoog9DjzUC8XXi8f+20AjOlTPlUo+ZJmgO0aSXBYSKDn2IrHn41qrGkSBCouJtOKBcaarc8
 htobMQf/uBnKDnoukfU12WQb3QAiSM+qtEAVdVJCrQ+skPO1AAYZmyGIJtubb4kMulTwYiAIpV5
 WUZ7SBFVthtuHztmetj6WeXIg9NyimMDgY4B+xbqix+kPEcKflexv4gW8MPweVcGgKf1/UNfJ4J
 uhD3jkBAuRNul14YKdPum798bN59HB1YC/b2/GlKlwHqcxwqJRZDkBdmRnKml1eB+gO+erk3XYK
 XuLP2h/S0JsGOIW7p+JUxA/Q2J0b0nNVFncijoebCOruQhsx/WUuCe7Ko/J1LTH/b5XqzG/J3/t
 AVWDzfH/6JCLXQpd/NJv8krG2tifXneFXiv/CZosrJ6QNS7N+rZSwpdFVyEpS8kPszPUGaS4mRe
 diNIZRVutTQr553jkqw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cc7e52 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Sz-QV6t1jvEebQ1jh4YA:9
X-Proofpoint-GUID: Z2ze529lH3UX93X32THcI-klTHgmuLxf
X-Proofpoint-ORIG-GUID: Z2ze529lH3UX93X32THcI-klTHgmuLxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010010

Hi Hendrik, Janosch, et al,

Attached is a small series to allow ESA-mode guests in s390 VSIE.
It continues to expect that z/Architecture is the default,
unless opted in by userspace.

I look forward to your thoughts; thanks!

Eric Farman (3):
  KVM: s390: vsie: Allow non-zarch guests
  KVM: s390: vsie: Disable some bits when in ESA mode
  KVM: s390: vsie: Accommodate ESA prefix pages

Hendrik Brueckner (1):
  KVM: s390: Add KVM capability for ESA mode guests

 Documentation/virt/kvm/api.rst         |  8 +++++++
 arch/s390/include/asm/kvm_host.h       |  1 +
 arch/s390/include/asm/kvm_host_types.h |  3 +--
 arch/s390/kvm/kvm-s390.c               |  6 ++++++
 arch/s390/kvm/kvm-s390.h               |  5 ++++-
 arch/s390/kvm/vsie.c                   | 29 ++++++++++++++++++++++----
 include/uapi/linux/kvm.h               |  1 +
 7 files changed, 46 insertions(+), 7 deletions(-)

--=20
2.51.0

