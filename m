Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E24E80A9;
	Mon, 28 Sep 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611141; cv=none; b=uk9Rzy73S7ANss4SiN9c5UahCRPMg2J64W6MS55W6iGLPn8t5hwSAYfPPJN7fDHmTr/5ZruJnDn4FHCZYdL4D6PiE45XbYdfAZlPocfybVcpLSccHD13Cm5D5QgeFu/+I7izm+4zQoj3bNVTTf3y/BKr9ddcSAEpmx8EZmrR93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611141; c=relaxed/simple;
	bh=04Ifz2k31JE157sSuBCrUq92PK7BGbZhITDHVUXzOwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlNug6otyyTnSNYh9iz29CfPoqw3IVSZDztTl488z8FZlrDOjCVWDm4lL6jcIiH5MgcwdobWjD/mh5Nv2S4rN15kWxa2b9w5qI5QSrmt3xoxsuKITAtpammDMOxUzObq53KrEMhlt018oQXKEt1PZ/BLKlzcQZ4HRaFMqKxmcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=grNeGLQF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="grNeGLQF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SF5YEY216947;
	Mon, 28 Sep 2026 15:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rzyibD
	QTpQayQMJ6uE+DAwnjNSVqg9HDPjxKT/D4jMY=; b=grNeGLQFIcNppKXXDKI0rl
	ThLMbnF6URl5Sg70BHzDbIBGMok1PcGBVunzH4LH80tr5xSz0JZgBdUTDZwRYHxS
	sPLeXAsV+2g7y/1QeXKOwJi+CBPnrVSh6M58EEb19sVkUCLXuNH73/d43igI4Lli
	JIm5jWsL+kNDUw2AMi6JTy76JKeM7uMDdqAtGyFMj8mgI//ioIOlpUw0HgPAMb2w
	FmziXcuPqxjwmI66ZF/hq9/GbOY0SjLKxmEjJVdLkzSeHV8i7SQL2HRx+OEz9P52
	rkRsPmPP+LcPyiKu0/0CZNVYsVQrktc9BQraPckbPlQujcnoT6tX0u4kT7FBgobw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe24r7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 15:58:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SElYxt290963;
	Mon, 28 Sep 2026 15:58:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y5qq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 15:58:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SFwWBo44040678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 15:58:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02D2620043;
	Mon, 28 Sep 2026 15:58:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0680920040;
	Mon, 28 Sep 2026 15:58:31 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.81.16])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 15:58:30 +0000 (GMT)
Message-ID: <c97ae089-fadf-4a29-b7df-4947ea8d6592@linux.ibm.com>
Date: Mon, 28 Sep 2026 17:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/29] s390/hwcaps: Report SAE support as hwcap
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-23-seiden@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba8ead cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=-Vzjgo3omqpRI_WBrZcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX4XV4UOxcfS7P
 0BbtHhPo3KhYsVIOb3OM9DJGdbUgdubsZz0PgqbsxfIQwCL713wGVSEIxXAo1kV+BTSks25F7J1
 NVpWyNmQFAq7cQFI010E63gNGvAYwws=
X-Proofpoint-ORIG-GUID: Mtrun8DKU0SK8lBZtLKEIDFHUbwLPE0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX4DHV58DlNGDR
 9T8Sp1CTOSVq/jLjjCsS4ZVoacGNvlbSs81VEvfmGDzJH7xQPd5kW/ZXg3Nx3PGSX8aJXvts/25
 uPF5HZMFIqBiDWtUBsv9pXd0ySQAPRYoAk1Ts1gpFYITkvhSZ7jyT93LxmzdafpHLywZxlC6b7t
 ZVQijeYBuyC8/bFU8HmvxfvehGbwo69D7uMTsWPDikZYOlUw0SASC23aAA5DybNNk6IZ/Yz3Sk+
 EplkGTF5eA3FTz57P8lCxrJ3bBRJythk0gvQ4/kiN7KP2MwOhVw/lJCcZpm70bEHzo/juFjkfMK
 qQWz26gJabzwTI3Em2OVpMB3etfotcopkdiz/bmB3g0aFyT5t2nBiQM1aF4Ah60SleCIwvkRZjY
 QlwDz2wZfHGJ4Z06HyOdXmby4zPzD/MX4ZFloFI7OPbKGOMl1XcW3Yx3UWLRT2o4qIJt6Ftlvm+
 XaaNGoeWKs0fPoD/law==
X-Proofpoint-GUID: VIifUq-Wtvu10B-gtNGluxlt-RnrP-Q4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280062



On 9/18/26 15:30, Steffen Eiden wrote:
> From: Hendrik Brueckner <brueckner@linux.ibm.com>
> 
> Report SAE support as hwcap (and /proc/cpuinfo)
> 
> Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/include/asm/elf.h    | 2 ++
>   arch/s390/include/asm/sclp.h   | 5 ++++-
>   arch/s390/kernel/processor.c   | 3 +++
>   drivers/s390/char/sclp_early.c | 1 +
>   4 files changed, 10 insertions(+), 1 deletion(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

