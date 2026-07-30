Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0195436BF8;
	Thu, 30 Jul 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421351; cv=none; b=rGmKGc7GFBZ/mrsn6JNsThhlu6QDiDEPqBKCmYnn3Ljm3BHco7TdmdizrHH34Ze5zEhis+bOHAUDbG8p6Gu7AkCDeZoJXgix9d4ZA13liFoEbRJzl6UWAiM2KGo9YWgUqKZAfQP74FtCJozwRs3aHmYYCVCPn/M9tPsekiGsz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421351; c=relaxed/simple;
	bh=KJSnyvdiAco750mGTVtanDSDO6A6n3AwLNo0d4+t5W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpLBHaREmUKgvIu/AVXFtpklFAKjxRFPL46fg53Q+ifvWP7Kzod9tH1t1eyS2rhqOtaipKYJhXol7O4vVLAhHDFB9gv6CDKygC4Jb6k0vG3ogQtyeMCQn/N1/TH2/M0THuMAQZyoxjhAOgJjMLEfP3bGcnWTmtaPedF0KaaRNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsofAuZW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsofAuZW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDI2hR3021096;
	Thu, 30 Jul 2026 14:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=UghDOZsVKAzSNf7EyXits0JuTMIlxcrKuhkq6t1eK
	Ow=; b=fsofAuZWHtvKmWeNfPASM8i7nCoTtMLeKqYbQDv78uPST4hrhLE36L5EE
	YVsBkiePK1FzKPp871tdif7xbP8B38gXK8C+25AUCazSbsPakdsgVJuPyih1eSfn
	Z6kTmcZF8ffQmNByk9E+oSpE0vmJFF5v54QK4Jyt8RNVftziXE+SqxiO1Un+Qabz
	q8WVFYgqIQYHmZDIYI33/uLuSacjVKLsBydlkNtwQLF6He2d9++4wWjQhJC/gO2h
	+LwmB1Ja+DNAmoCNzMbDKIRxEqGTLwV1IdvtDel/5JkDb4YsyzxCVEbZ+PWL2cho
	WewWdnQOli78VijklFQU5HLf7ceyw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfagr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:22:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEBJoD013233;
	Thu, 30 Jul 2026 14:22:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhkm7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:22:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEMGHU28836396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:22:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D45EC2004B;
	Thu, 30 Jul 2026 14:22:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 898BF20040;
	Thu, 30 Jul 2026 14:22:16 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 14:22:16 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, wintera@linux.ibm.com,
        aswin@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, hidayath@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH net] s390/qeth: validate user buffer length in SNMP and ARP query ioctls
Date: Thu, 30 Jul 2026 16:22:16 +0200
Message-ID: <20260730142216.218309-1-hidayath@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfX5lmiucqFddfX
 VEB8K42UlOFXZp5XWFee7p/ZRoA4KEsYkhtnZIsDbwESJe/ef+0KK8Hhf5sGZiq0JU8xYlJ0++j
 PhDg0fTMMH64a5IrOldNTahZOVKxm/w=
X-Proofpoint-GUID: iF-om9MhUhz1E0-T4S7USqIjuj_iAjhr
X-Proofpoint-ORIG-GUID: SgpBaxh1ByQordkDx0Iz8mqFkfQ75pbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfXw+ZTc9qAqrov
 iLx4Nk7ZNcMKZzOkskHH+k2g4Tl0jEMa95+Q+nzOf35CXhAifpPYfkGnX0vH/LOBCekZAZrjczp
 G8//UBMh0ij3XN9DfbiPH+ukYglJ4mrxmU80fT6kDb7A4Bn1VAIRRaFkWP+Qp/aNopvD2s5jdnZ
 4HUGuiyRsxfDDF0lg7DeI+5ZdBzSPi0CHF8Ne3pTYjW9Od9lLytFgIYr4BfMuQos2JfsGKof7DD
 uIj82h0S+QG66uHadCF1IhAvgEHh+oC8ap3GAxTRw/qNsogH2V3zjWKmZqnx3HIFXxl6w0iQZq/
 GvClnJE5HAmXkEJngBJUBejgPQMpivm9eJgw4BuE7IslQ3WiPdRZ8L1fbjmeoyYqWrBHA42JUBR
 vDBDhm9oXv3VJ4rqyZzpi6flrxJMhfrTbPHwycF/L/XhAfqjptuEPkfedy/92lf1q0lJrDBncrF
 PR5I6l9dV7LCN7RM+kQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b5e1e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8BjajkXoXOh5Z-NPRBsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300109

qeth_snmp_command() and qeth_l3_arp_query() allocate a buffer sized by
a user-supplied length (udata_len) without checking a lower bound, then
set udata_offset to a fixed non-zero value and pass both to a reply
callback. The callback bounds-checks the copy with

        if ((udata_len - udata_offset) < len)

Both fields are u32, so a udata_len smaller than udata_offset makes the
subtraction wrap and the check pass, and the following memcpy() writes
past the allocation. A udata_len of 0 also yields ZERO_SIZE_PTR from
kzalloc(), which the existing NULL check does not catch.

Reject buffers smaller than udata_offset before allocating, so the
callback subtraction can no longer underflow.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Cc: stable@vger.kernel.org
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 3 +++
 drivers/s390/net/qeth_l3_main.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f18eed9df3c7..c3257b213360 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4710,6 +4710,9 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 	if (req_len > QETH_BUFSIZE)
 		return -EINVAL;
 
+	if (qinfo.udata_len < sizeof(struct qeth_snmp_ureq_hdr))
+		return -EINVAL;
+
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
 	if (!iob)
 		return -ENOMEM;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 1542bfc9f561..f1ac9950dcb4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1415,6 +1415,11 @@ static int qeth_l3_arp_query(struct qeth_card *card, char __user *udata)
 		rc = -EFAULT;
 		goto out;
 	}
+
+	if (qinfo.udata_len < QETH_QARP_ENTRIES_OFFSET) {
+		rc = -EINVAL;
+		goto out;
+	}
 	qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
 	if (!qinfo.udata) {
 		rc = -ENOMEM;

base-commit: 58c1c294d685baf94801839334df20501711eb8e
-- 
2.52.0

