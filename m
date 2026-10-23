Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747287;
	b=hqM3wpm/KYJqjeTXT94ad/fJNqgGy62AEtqCCayCGCFx9t3rda1slNydKUkmCax1t9ca
	 ZTuojVjEUXxqjGSG5m1jwO2/U5vWDeTikclX5EH4v/IFG/UMk09Hf9YlrhSMIal/BCkam
	 DXK6St7+1gYPimKTidMxbjY7MjNxxdx6AqZzP6TjM77qheSarpr2DuWBH47idiM5YIqEO
	 VrBlua81v2kLtaXVA7hNhw3emWSBRNS/ghgE0IKp1PciP4TdBWp/AJYDwXhP4bz3GUc3b
	 qv/mhtpGX98nMbJ6OedKLVD6bEt9t+PtAasQ1AngZgsssFMWcDiigE0dNynh0Twq+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747287;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MGf4HTp70/VQhTrKrPsXc5RMCQeORS9bCe+fd+bICAc=;
	b=gsG/kQRk6brbmJ8FpmHEmdlbC87vzVEdzqUa9CwXZkWx0ERBZOaMo1jFM/BdLTklEnm1
	 h5c9ehLT3mv6wGNVqnBazTfErHzhene/S0nXlngiVoZx2l1QCuGzGmguImIlHeMHBeTSI
	 WDgaodKTW11LR8Etm324foSQEqI18sTenrIVeO6oEu3mwazwSUSNNgwUmma1STBBsa7YC
	 PhzipbMqkFDEUKFw54JTSgIJwxEUTfserPxcTV1qpmLhT/RGE5q0XuV9zQZi3g0ykXOGk
	 uQwazXgTyetcjofZJ+Wh1cWztSFr7kMU6fzPzmgU3ndfEkO2WzVM+x9OJMKbSUgNxdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="XS6rJ/15";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E57606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E57606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XS6rJ/15
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7ErCR2251358
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=MGf4HTp70/VQhTrKrPsXc5RMCQeO
	RS9bCe+fd+bICAc=; b=XS6rJ/15cMyFbHJ1uUqndfwje7E3ZahWRBQn9HZcW4Gx
	Dk6F05FheMnPUAL0gJb6HN6C0etIj1wyqhPsKg30y50MKyqYsBzIoQ0ljAOh7Zso
	jZiJvZUj4LvTiQKKC9BTvf1JyC7YsOk+hmD8tymrhxAOZm2qePyEgC882RVbN3RP
	ScAeEGRO/8rDAgOX3da6zilwHv+MKaRm0c70RyUw7ZIDHL1UZDW6vORWzaq/RRWn
	hmAOfzqAIw70uu4gaOevgyzhfp9x0McLnmMYFHfcAjxlbstadQKty0qX9aXuIWVc
	JhYOabuFsy63ixoqhkBaRx1AD704H1pMQAGAvRakXQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5abmyv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Jwce1800687
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn3tcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N9LKAO42533202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 09:21:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8B9920043;
	Fri, 23 Oct 2026 09:21:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B284420040;
	Fri, 23 Oct 2026 09:21:20 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 09:21:20 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH 0/3] s390/dasd: Fix BIODASDCHECKFMT issues and RCD retry handling
Date: Fri, 23 Oct 2026 11:21:15 +0200
Message-ID: <20261023092118.3152286-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX6CToF/GGI9ZR
 em/DDKmRlaUeJfGDCtgblXaQ4xu4beVA+FVTlx0Lw7S0qFR7DvutL+9IZNovCPMD1F5ugnYMl5o
 KTCLCLzUvNTLe6BgFEqNFVeKMm8/xSWXNVbpZYnF0yu6CEwWsIAoFqPDntN4wEBMGutNa4YuCb6
 UyjZMcnBt5pN1my+q5+/mvRD+Yy2B45WjYnyZPrPzHdMC8n3PPnANT/2gZ2kYjl+4jysyIA79lN
 gmI3EodqbaLmROheLe0elKQ4RhrOtXHbiLctPhWD8Daq3A24aNJTe0a+EJ6FaK0zHEbTUhRZlt5
 KM89bf1hzgKNAvF9JtvkgwB5DvWaaR6plR5wTylgn222ojALuLW6CTPOolhgJbAI5MMRXEdQbQV
 dpqTj4htVL2WBDXK0yHlqe8gdAMam3UZwPYDxXrVkCAtpoVS1Y2LmAVVI9OKwP/GlUREsMGlPrk
 oubA3yRuNOyFdfO3v7A==
X-Proofpoint-ORIG-GUID: _MXkrR1_p6b0hIhB3qa99b-jsEbzLEpJ
X-Proofpoint-GUID: _MXkrR1_p6b0hIhB3qa99b-jsEbzLEpJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX8nDChjl7D0hV
 IeD6CCVdkshgjDHL6wzSC6W2yE0ifjcbatxKC0j8kayrX2q4c6p840L+lFhV0JjAMOW0MKVrZRq
 ZMlccuZP/qQoONMWSGMXZLcaA2MJH1g=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6adb2715 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-c3AWK87hgQx3XDiw_sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230036

The BIODASDCHECKFMT ioctl gained several fixes as a result of issues
reported by Sashiko. Two patches address bugs introduced with the
original ioctl implementation: one prevents userspace from influencing
internal evaluation state through output-only fields, avoiding a kernel
heap information leak, and another fixes an error path that could crash
the kernel and leak request references.

The third patch fixes a longstanding z/VM-specific issue in RCD
processing. The Read Configuration Data request requires a special
buffer initialization before every start, but several restart paths
bypassed the existing reinitialization logic. As a result, successful
retries could return incomplete configuration data and lead to false
"Not all channel paths lead to the same device" reports for otherwise
identical minidisks.

Stefan Haberland (3):
  s390/dasd: Re-initialize RCD buffer with "V1.0" before every start
  s390/dasd: Fix wrong free and refcount leak in build_check_tcw error
    path
  s390/dasd: Don't trust userspace-supplied result field in format check

 drivers/s390/block/dasd.c       |  1 +
 drivers/s390/block/dasd_eckd.c  | 55 ++++++++++++---------------------
 drivers/s390/block/dasd_int.h   | 15 +++++++++
 drivers/s390/block/dasd_ioctl.c |  4 ++-
 4 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.53.0

