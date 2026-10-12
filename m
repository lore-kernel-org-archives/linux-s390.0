Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0630DECB;
	Mon, 12 Oct 2026 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815182; cv=none; b=DNMajZhqW8HvKNehYWAdjGoxJXFXuSASV/0vVzdQFNpheIsSmT2KJ+HYhVBPwjrswZ/O1Br2nCTeAYHZhZdmr1Wzv0+7hUisi0TDFiLMngFaVRVPPpU89rSfzXatzebCYMKoYj7zciQgnXomd+bJVbbBZ7BAtFLvAeD9J4RBvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815182; c=relaxed/simple;
	bh=7tyMyuMY2RWMRQxVfWOIxbVAs3VMazs8/uFEG8xtf2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzG0sB2NLjQLGEFoeS//kwpBvDUbQfBprInhEwAydFA1/FzFBzdwhhyF2oF8uCm9DpwxOX4cM13DGtStVqMEtPz7Si8n3ZLEBCiNVn18chSQMBS/wfubL46CuHjGFdXx8rEMsTZo+PDDcbrO/qelQqegakkFlsapjfw6UWL309k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NClHYtPH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NClHYtPH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE6DS315872;
	Mon, 12 Oct 2026 14:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pl/Qm1
	jr3Pgq2D86R6t48HrmeA0/UhqCNElBDwe1p4s=; b=NClHYtPHwakl3/9hIFTJsE
	+fFHeST1Iv/QgFya3CNPEF3ouXPgMb8Cr+GR9GgUQYTEAlI+O740TJelCHRbvksc
	pBm+Vtw0yr5jV+u8lmQPKlsuT1Yx3IRJkauw/VBAsvlF52U5GFIRobtQy0w5IBFz
	HSk+z2WNmAZCAgCPnkTgtgKhX7saEa/4zTHNt5MCM/Z8dxjWv8i3EswBQsm0VLuR
	KBK2gQp0Z6fCQePb9QiK39zGchp8cPX8K3qm3Ys4dt8XxNKmR20LHY7DfrRK6KcW
	zINLAFaDapfEiSWCvvDW8OSYkOQTMJlajJGeucgkCPZzjgKDfNZ+muJEG1MyekCg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug9bws-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:26:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC5AEm1238650;
	Mon, 12 Oct 2026 14:26:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnppv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:26:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEQFqI39715078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:26:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B09020043;
	Mon, 12 Oct 2026 14:26:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20D4320040;
	Mon, 12 Oct 2026 14:26:15 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:26:15 +0000 (GMT)
Message-ID: <b32c5481-32f4-485a-b8b0-96c3e79fdaa0@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:26:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/32] s390/word-at-a-time: Convert inline assembly to
 EX_TABLE_INSN
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-24-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-24-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accee0c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=W3_Q4jTRMHymxWg3qskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TcadONBcZBSJXxGddjmLXiEAWhGp61Qa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX+3u74Hg4W6zI
 KW5c47MlYkDL7sm1TqHNN847koHtqFwVJuNuUNzonGYj4cI/7KFoz/md0TLR2awiw4uF5J2ynXl
 DPJJFMOeKLHAh95D4kACmxjrosLK02Px9f4KXgL3ib2Qpx/czPSfa6cS5EDVmdumnRIXPu5vtJx
 MUqCtMwSAqnRI06ewPniqtAsGqtVOMh9BZsu93l9oQNxIsHXdG7/i7lDSf+JW01dEjwh8jRsoIB
 SMLX3DJB3m7Sj/0WNAEjv9UaOElukXrCzDOPcDb10jAdopVhVMDa8/dEffAiYHxvQh1TVccBdwx
 F7HIP1AG7jIhiDS5VsCvt/lN7zr57ifc8H5pHlUDb9X1h8TsVAs6T47wdb2uMM4nTefyQPZGc6+
 cqjS9ylVmjmb69Ntx9rg9KiWp4x+Qv5EileFIGLr0vIuXI0RsF4IoI43QEKYuWh3B8X7v7J55pO
 LAMzGcARc0lE0l5tozA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX3mfDSo+o1cpl
 QllSUiaLcPBraTBqqZRb2dTHD4+/azigkWsb/S0REfay9J7ZzKmLXwWHm7OzmZkJhsdaJrKu9yX
 T5fc8HwS1zThbyP21HHws8wyXS0jIxU=
X-Proofpoint-ORIG-GUID: TcadONBcZBSJXxGddjmLXiEAWhGp61Qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the load_unaligned_zeropad exception table entries to use
> EX_TABLE_INSN. With EX_TABLE_INSN entries always point to the faulting
> instruction, so the duplicate entry and nopr padding are no longer
> needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/word-at-a-time.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

