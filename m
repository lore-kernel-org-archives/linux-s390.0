Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506803;
	b=m4cBA89JbbciQNS+4Jf9C4NNbdC4dNV1qzTB+TQr4Dtm3umNJSl2QWhotLYGKNJIOXv8
	 olP8binUrtttTqZKPINsvEVsPBOr/U9JHQCgfX210JiucpSzUE/RagzwAaJcxkLA1aNYX
	 TIKXDmVgaaxAX0SmY2lwgZSjCPmGYtrZDH8+sjRH22kAIPTEPy5efaCtYjepW4tZwWjBV
	 RE6QGjyCIvsff5yV/zj7hB8CCQUkU2iMwHi+wR56Q7Vv6ALgMq5opW6VhJKkgT/xjwPla
	 5rxlzTlmbHuBTQk+Z5psXCiDGxKibqHl+sbbObINtSlER1/ZFUWb5Zml9U7fmv62Xsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506803;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GNwYkcxFnxn+Md+OfH9vp+RCZ87JGPZMRvsSRg2s52w=;
	b=asyR2OsWqrdwzWchbAUBPIw0NZFyXLqX04XR1Mh2wqmwQpLCeoroY625GiD9+a9JrYeS
	 HwZWa2QFH+xYQfw0RIBnwT7VWB1GFG1t5jWBYdjlaHe8njBGfBVqFmXKNOqD4XUmjES2m
	 /6xQCJbfamDjUSG1qb2mKqIC2VHs0cBJEqWi0bN8DLEoS4D9RJslg0+Rqgn+18Mh8h0jF
	 3UgSujY/1zIzDybOmpjNhtKYMbia58uKVe86YQXrBYLczfIH/OgUwHBmDuudoaHwErglk
	 UkR4hXohxVaFwYJRniva8IzAbiUALGg5mm3OMfv5BI1bFd+PiqcW1yFnNGWZ7U0BbCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IFpJcDj1;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A8606A31B;
	Tue, 20 Oct 2026 14:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C1A8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IFpJcDj1
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDEFWw2568733;
	Tue, 20 Oct 2026 14:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GNwYkcxFnxn+Md+OfH9vp+RCZ87JGPZMRvsSRg2s5
	2w=; b=IFpJcDj1yw0rLv0mbcoEFuaJIGgNR8qyfqZc5AejLqcgKPwAyVq4VwQ4j
	TxwBauJTHjS6fqEf78MaXtFuur5//wsRXCBW1E0SDmwOYBQQ+8dkwBpSsw9C0KtM
	/UyOk+X32Auu4VN+F32wKe8HkOSYuALbSA22SvNVbfueIZvHw1l08T9vsWiyVqIp
	WgPkD1jA5ScFCGfJYJlRc1VUCq5fDZiae6f/oMH5ptUYIOrAV5roZFI6dfRQHDX1
	Bav+U9on6sCvkEbAZ0SB6ti66J/3tdSDb626l9/sorIxx2v+IvBOYAX3JdxyQ2e/
	WPl8Janr/VrsFfe/Bo+NIO2CYnOBw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw59u8ky-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:33:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDK1pi350705;
	Tue, 20 Oct 2026 14:33:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjh29ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:33:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KEXAis1442504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 14:33:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6A8F58060;
	Tue, 20 Oct 2026 14:33:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6317258051;
	Tue, 20 Oct 2026 14:33:09 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 14:33:09 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 0/2] Fix error handling for async_pf
Date: Tue, 20 Oct 2026 16:33:06 +0200
Message-ID: <20261020143308.228328-1-borntraeger@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX49+O20XXsoes
 Ha88zpZw/Yt+Pacaf4DbELnh0xIxqgZcZBPRplqmAh/ySkLrnVUVkOakUpSWakQWQiqIVm33ngJ
 0OyOZHqZyRqos2hHEHw4vq0IxrT6bxYlevGfZPCwtoXiGJZ5tkGyEfWNIt839YUvmkNndhN63Uf
 UyPWFqbX88jTKDWMUyKk2CtIsjyVvxFL5wnEhQONtiFOwtwExEV0XI1JXtcLPfS6sutrHmoocp7
 OVl2VtvH3imJuSrKiA22jomBsCS7yzsFNcumMFxvXTCZvV8eqRndr2zOylJd7YPhc6/fNC8NVYB
 ndN/w1HmFAs8xlZHKbp/pXh85hq0mK4Vd9qKts78a9yeJYQZ2nwcolfqVanGY0ffEsk6iWQrp7+
 XvMhmiao+M/dbmOZO85qAxJbWzWXoMfc0KAK9vhNTIVPDq/3w/+7rpYAg0lZAsSCa1AOGPsWCsm
 R+8PCiOyQis6L4Me1Cw==
X-Proofpoint-ORIG-GUID: v3Jrxt96XinBouBF8IuU79e12LA19tu7
X-Proofpoint-GUID: Se969sSIiqEvh2hdyKlSX70gZ1Bo-rvo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX03+AnSU1Fuw/
 3b/bpXyr3wrrx/44djdiTb3UI0Mxf9FgVddlqkNjr/fXJxxPGrtWRJbZZmXNXJMVhBMkoJCJDNI
 1IGyCu7LvWMN4dV+xqg3ZlV1NJArxA4=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad77ba8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=JYCxxj4wjfSeNEK2tAkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200056

Return mapping errors also for async_pf cases. Otherwise guests
will loop forever. Nothing critical just missing error handling.

can certainly wait after the merge window, but if anyone has time
to review..


Christian Borntraeger (2):
  KVM: Set up async page faults only for faults that need to wait
  KVM: selftests: Test that KVM_RUN fails for unresolvable host faults

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/faultin_sigbus_test.c       | 168 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   1 +
 3 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/faultin_sigbus_test.c

-- 
2.53.0

