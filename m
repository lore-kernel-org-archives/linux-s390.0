Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDF405ACF;
	Tue, 24 Mar 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366137; cv=none; b=nMwniAES2gw0aFdD0aRcIFAWfzSWLy0nO5WB8wROiWyiYvXAbG6QwkIU6H5tTmPP6QGOnCfYz2CoXanbimEpyhv22MfxHBRwMberUqAzpllO7DT/5HGqe3Ds9PSM+rYD1vLe5F52y/hQQYI8tBoTfvjD+2S4iblyZIzv5vdXLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366137; c=relaxed/simple;
	bh=QVqNekbtwElcjfNlljswiUXEH1gWtf4b6loCypIE9FI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WG5k7PNHEj5uQm386GJheuGGj57XZbiameyC4V+aLk8YBXKTP1mBtQxsWtY6LCnQ4zf0BO/lfgRvyJSzSJxNuHzunYHZeZQmPSarBFcofyQHfAX5x51JhhJqCXiiOFQQo3/9593YsN10+x3iLHd1VQRTTrLRmh8EeunDWs1MEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JlyVUhJt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JlyVUhJt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O91Ur9511484;
	Tue, 24 Mar 2026 15:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=zxMDVjknWPvdNCJe6yckbpd+E592
	Xso7jP8jR1MP8YU=; b=JlyVUhJtZ7ab5M+CBEWenpeotpj1ArQ339N5hoZPnkQD
	LCFnVVgsrGKycvsG4g0iPqb3+BSxXXYQFpUvI7I6SLTWQVQe6r9L1BPCfjcRPUrL
	A2EOO0XPJKeQX0Wjc6q5bwn+gmWNLjbKFrcZmh8pfmPQiX4WkWyB9enimAHiGWPC
	bv+vXYpwhE8c3RGqg6Jx+/8UVCRuF8ECIPDSLfr+snwN/sMXtxdDECMQNhfRSIJD
	3rX7kQ9dDwpzz8Ngg4cVYpQnNERYZiHgl36s+AcyfbN2MzqT6EnXBLcwAEaBjxy8
	Y6XAi+1kq7E0eQMhDX5jGvxAk99sl58bbCCXXqTXvA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9v882-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFJ7hj031687;
	Tue, 24 Mar 2026 15:28:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nstmu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFSj8E50528544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:28:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD2F420043;
	Tue, 24 Mar 2026 15:28:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A3E320040;
	Tue, 24 Mar 2026 15:28:45 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:28:45 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/5] s390x: Add test for STFLE
 interpretive execution (format-2)
Date: Tue, 24 Mar 2026 16:28:04 +0100
Message-Id: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBBEf4Xs2SW0VlBP/ofhAGWRjVJMtzQYw
 r/b4M3LJJOZebOCkGcSuGYreIosPLlk9CEDOzTuQchd8qALXRZJMAoTSuhfhH1j0RRHMqasujN
 pSKO3p56XHXiHZxxxdhwwkASBOuUDS5j8Z/+Lam/90Er9o6PCAk1pq4bs6aJ0e3uxm5ec2zG30
 wj1tm1fLqYC88AAAAA=
X-Change-ID: 20260202-vsie-stfle-fac-403e4467d8e2
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=QVqNekbtwElcjfNlljswiUXEH1gWtf4b6loCypIE9FI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmH1q6ee6VAxX5ryh+vBwqMK4xTVd4nXzvewfVEo7xoz
 xJZvqA5HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEykxZuR4dZ/bo7eAp9Dhrc4
 zXMXm+w8/Fz5oTP7Qflyz/tvT9zefZ7hn8nurHnSBfGzZqrkzj5ituZiZ8ZEz17342cY2Fm/vGy
 L4QEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k2ikndC6j636EZx7jc3SvMDSaPLhjrdl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX5E008UcWf+27
 OjcoAIbuD2E5Gla59EeIVsQJ5v5ywQx0tQy7aDxABWKfauRFqRVHoYHMM98nHDMvwTFHl9Odqyc
 jcuS/lLrPC1S3aW3QNsyIDJXZ9gfM14N7XeJ2BErPFFS4LGiNHprDRKqplX2rhTWTXF0ABc+Vva
 IXnU5OUfdarzNNuRVzBzJ0gRPgOhKv6huwPPuToZbGCPuPxc7wucWYP7KJojO9+tW0yURAIsruW
 /Su+UQms0cBr+M9bQJazkdwL6blEQIN4oejv+Y99g2k02ustxtd7huMZ1fIYu3g9OzfZbNHShAr
 r7vShamhTTSphNGvrjAgi0ow1ZQO4M0LU/1f3TQZdK3bwOGh7cYxhDKhl8JUNrF3zwQHf69gx1E
 cnJ8OS5CsLNWsBazbxJRcvwm4pmJU0g3AxaFw69fVeddJXuPAfGqp28AfsYkkj1ArIKsDY/KkTY
 b5Ce/SmSLvPwk+dITfg==
X-Proofpoint-GUID: k2ikndC6j636EZx7jc3SvMDSaPLhjrdl
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c2adb3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=1pEIAPF2W-qNjrGd5QYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

Test the shadowing of format-2 facility list when running in VSIE.

The tests will skip the format 2 tests
* if running with unpatched kernels or qemu in G1 or G2
* if running on machines prior IBM z16 GA1 (where ASTFLEIE2 is not
  available)

Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Nico Böhr" <nrb@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>
To: linux-s390@vger.kernel.org
Cc: kvm@vger.kernel.org

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
The original series was started by Nina and finished by me.

---
Changes in v2:
- Rework sclp_facilities_setup()
- Removed explicit manual padding from struct sclp_facilities
- Link to v1: https://lore.kernel.org/r/20260211-vsie-stfle-fac-v1-0-46c7aec5912b@linux.ibm.com

---
Christoph Schlameuss (2):
      s390x: sclp: Remove unnecessary padding from struct sclp_facilities
      s390x: sclp: Rework sclp_facilities_setup() for simpler control flow

Nina Schoetterl-Glausch (3):
      s390x: snippets: Add reset_guest() to lib
      s390x: sclp: Add detection of alternate STFLE facilities
      s390x: Add test for STFLE interpretive execution (format-2)

 lib/s390x/sclp.c    | 30 +++++++++++-------
 lib/s390x/sclp.h    |  5 ++-
 lib/s390x/sie.c     | 11 +++++++
 lib/s390x/sie.h     |  1 +
 lib/s390x/snippet.h |  6 ++++
 s390x/spec_ex-sie.c | 10 ++----
 s390x/stfle-sie.c   | 91 ++++++++++++++++++++++++++++++++++++++++++++++-------
 7 files changed, 123 insertions(+), 31 deletions(-)
---
base-commit: 86e53277ac80dabb04f4fa5fa6a6cc7649392bdc
change-id: 20260202-vsie-stfle-fac-403e4467d8e2

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

