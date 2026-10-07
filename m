Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F98360745;
	Wed,  7 Oct 2026 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352984; cv=none; b=pvqjT6aPFgJEcbmiNRXPfCVHDHqCKF1syjFzqUay9kMcI41WEbgkyNi7jEs5yCiVNGcDLFHRKuZ0oGZWXqrGSalE3RRuCLj3olb4u/WkIHhZc+SN+n0wttDSRhx6ylxcRNPBT71I3p4Sfp9HTRNFD8yghJXtTG1/z4v5ssu5690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352984; c=relaxed/simple;
	bh=Twd4QPSMnhEAZ6eNYHQPUdwe08ccOUjpfOhnOIWIgcQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=IWxLMsTsRZVjDsIdOLdBAiAN0OY/kzXATeq2kxNoRFfmR8+KZx8dFb3NtgGjl8Q+Za2NxNkaGqTJvTGRIxDjTcPKTt0djM1gZYmPjlyOe0wBjON86BPtxgZbsLx218c5lEq6sD9i8BXzqWBaeIS/gePuQcPhzdjTHExqW7LpRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ec0v8xVG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ec0v8xVG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974aM8I1409150;
	Wed, 7 Oct 2026 06:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I5jlJn
	E0No2ZIr3sR2xudJs8qzwwleE6Sl8rMLfLRW4=; b=ec0v8xVG7Wzn5XnpDGaDJ5
	BkLmhpEg9Dp/ZOQFmGkKihJibmKunuiNmQr0QJ877JnHdnqk1zDHVhFfHpNhB31x
	t9HqvsIqqPD1l0GUhsIVsJzYCA3T5e2TDW7Q2gZD5pdyv6ABCdo/akY4QxzC5B30
	a9yhThvtmaQfu2nHyJmVw6WbxHkmbTVW8dS2MX1lte68Fo5hENJXq/Qgz6fMFGe8
	1WwyCDtOsPoftJpz6y71pWkAA5SqX48+4wHwhNMR82Vyuh9sQeVXRTfbNDIqju89
	aYu66r4Q44dTteeYTGsjHPI5kUIVogfduYGn6AH6+V9Putm7jwOMBbi9IQjaLVeQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4juat0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 06:03:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6974WZVJ100192;
	Wed, 7 Oct 2026 06:03:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tr8s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 06:03:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69762vME52560228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 06:02:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E338A20043;
	Wed,  7 Oct 2026 06:02:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A72E20040;
	Wed,  7 Oct 2026 06:02:57 +0000 (GMT)
Received: from localhost (unknown [9.111.168.1])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 06:02:57 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 08:02:57 +0200
Message-Id: <DLYDMSY53U6G.3SEUW3DCM70AZ@linux.ibm.com>
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Tobias Schumacher"
 <ts@linux.ibm.com>,
        "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Julian Ruess"
 <julianr@linux.ibm.com>,
        "Farhan Ali" <alifm@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Halil Pasic"
 <pasic@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Sven
 Schnelle" <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] s390/pci: Fix use-after-free race in zpci
 floating interrupt cleanup
X-Mailer: aerc HEAD-0d169b7
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-4-d45b824874c0@linux.ibm.com>
 <ff4e4c7cbd39dd457892589a5f75e9be0bcc060f.camel@linux.ibm.com>
In-Reply-To: <ff4e4c7cbd39dd457892589a5f75e9be0bcc060f.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vn-bktPFFv58jOlubg4XYe-q0xb9XyK1
X-Proofpoint-GUID: vn-bktPFFv58jOlubg4XYe-q0xb9XyK1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfX4Hy/jl2hyyK0
 XenSjvEGPYtch9Ynw9jot3UPC8V3uO0ioueBJ4nV8FDAVTxSOjuZXB032HKhLQTI+um1Cm8K92n
 iG/k4CJz0AeRIyCymmLqWNTfvLM++8g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfXz5NRqxr7XQwk
 vqpNtOFNsUeocgTk5Disg7NZDhhr3XeQD6QcgmRUJ0ugV+EncnuTLtzqLs9qQzatCHReWYIFfSx
 FhJAtRb8OQszuW2hBoork7hJaaojgTIhOCYEBOZmUWcYYWGhZaUAz1WQXVVIFLrx3UEUUWjS5Ut
 XCfBq9J6mIgmS7l6A1rnLU/Z1ij5o/pBHhpuRVmolioJmQ/3zgGzIRW13vAey0Qb7WzfSCVbxwr
 br7XcgloKsIu8W1rI9gdrPxy5Yeauz71yljH+51QgbP89csKWFZnVcxj8CoRXVgUje+isUSYu4S
 hi2MRuFtxir1uKewOlIBkiyfir0BScconb5DozIV9VJuEF+9iSRedNlKZrIpGL6/s6cdsK/bFz5
 2M8h9HyhHhhmFOktQ1tbRol2di6zER6ofmJHlI0z/5qtd17teQQD6oMj4JzQAydI+3cGhz5X7Aw
 WvZ9XUKVCexlH5p0Qug==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac5e096 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=A5doXAPnzZ6mdjI_Yh0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070022

On Tue Oct 6, 2026 at 9:23 PM CEST, Niklas Schnelle wrote:
> On Mon, 2026-10-05 at 14:03 +0200, Tobias Schumacher wrote:

> --- snip ---

>> @@ -660,10 +664,12 @@ void __init zpci_irq_exit(void)
>>
>>  	if (irq_delivery =3D=3D DIRECTED) {
>>  		for_each_possible_cpu(cpu) {
>> -			airq_iv_release(zpci_ibv[cpu]);
>> +			airq_iv_release(zpci_dibv[cpu]);
>>  		}
>> +		kfree(zpci_dibv);
>> +	} else {
>> +		kfree(zpci_ibv);
>>  	}
>> -	kfree(zpci_ibv);
>>  	if (zpci_sbv)
>>  		airq_iv_release(zpci_sbv);
>>  	unregister_adapter_interrupt(&zpci_airq);
>
> This is pre-existing but my additional LLM review noticed it. It
> seems like a theoretical race and against the reverse cleanup vs setup
> rule, that kfree(zpci_ibv) is done before
> unregister_adapter_interrupt().

Good point. Since this goes back to the original adapter interrput code,
I'll probably add a separate patch in v3.

Thanks,
Tobias

