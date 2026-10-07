Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876723033CB;
	Wed,  7 Oct 2026 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353420; cv=none; b=FfV6xF0DRR7iY/8wIhx8Zk8oH4sgsdxpa7LOz+mgIOA71C1740VX0MMuyVWC/6jaf1ZQg9xaUI8cJcU+eHsV7NptJKuGgtHKvq6IlYzPLgdsBNSQWtKE6DZXhbqSrVW/Ezg8UmQSTfDsmMOb4Njzoyp+ITiDn76mRK6U00NJ9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353420; c=relaxed/simple;
	bh=ceZFEM/VyIzkK5131T633yMTN8zQC3PLBwJk4s0qMPM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I5pQcBOdHVU2vNIXFgCWN/ZI4sxOUMu30gRGf3c5foaf34rVWB8CB7Xg1sf/I/GG2CPJ81h8ENFIuQp+rExt0N30uyg0CnRy3/5Y6oxQ0mfxUUQCZLh4uBucLcGR1wGRPntor2CJcW0x78cP0/YM83rFOms33IbtnFxsgSwjNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LGdG6WVh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LGdG6WVh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974Zhlx1549457;
	Wed, 7 Oct 2026 06:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ceZFEM
	/VyIzkK5131T633yMTN8zQC3PLBwJk4s0qMPM=; b=LGdG6WVhD4yqqmEG+tXPv+
	w7s/BRkWh3dOohIEPX9Sbk1oq8O7nksPZEfXMGGqoHfd/Hstb5vuaIdMMCh/R/Qw
	vqSL8o64uu/2Kj9RK/jUWiwd6sxT1ULmAp8HegJ8xjWgovQRifxXzNU+aJ0n3jMT
	KPzC91G0x9wKHVOZXKQXKnqioJvycbNpVTqwmxsq4/qLQxEn7jnOoyClwIAiZvLN
	6mzyo9dQZyVUsCqwQmR0VgJ+836ciJuvXkfQM0S/aZL8E/Rhotxw0MtdmpNytpVl
	kypsP8Cgx2ANu1Rl5GmWxf6tNNDNKdomhgpTDKxIkmf87kn2Ni4klLz9pwu3oNqw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbvaw01-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 06:10:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6974Wghs1393951;
	Wed, 7 Oct 2026 06:10:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgw9ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 06:10:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6976ADmD56295846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 06:10:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611672004D;
	Wed,  7 Oct 2026 06:10:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27E320043;
	Wed,  7 Oct 2026 06:10:12 +0000 (GMT)
Received: from localhost (unknown [9.111.168.1])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 06:10:12 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 08:10:12 +0200
Message-Id: <DLYDSD0HXOAO.1Y1H1RMHUNSDG@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Sven
 Schnelle" <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] s390/pci: Add error cleanup in
 zpci_directed_irq_init
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
X-Mailer: aerc HEAD-0d169b7
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-5-d45b824874c0@linux.ibm.com>
 <f5817b10564942c8a3e1ee309b21ec0bdb803e97.camel@linux.ibm.com>
In-Reply-To: <f5817b10564942c8a3e1ee309b21ec0bdb803e97.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gURsvKLFVBSS9nsrKj3hMLtiWo2rUQ0b
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac5e24a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=wzXoPis5L9NAWRF77LkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gURsvKLFVBSS9nsrKj3hMLtiWo2rUQ0b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNCBTYWx0ZWRfXy794HlQF0EH6
 kB/GZar+X3OXZ0OQOkbgBNAVrMwDzkr0QAqrQsmXHcvQKCBGIMO5x3giv+S8YnCYz3lRbPlOzkV
 wKYgf9YzIiCXD7J1qpGuVLqkxEDK0NPXCtGWCN3EUmR4GP6Lm8ztbQycnVlIiZNTgZECwEu0+EW
 2jkrdBOUJjlh9AHUDNoLBrSCMNovj6Ui+2+s2U2VtNLl9dP/7LFR3biwZFHB/UHzeKdPrkLVk+1
 uyZkWSd7WrMfq4UVSudF+4zPXMRg7hqOPHuz93EMLDEMZ9Ele8MOAw1R6KqVgy7IuTXKbknZEqE
 /AaahOgdkwRzqfj+ZCe+cpLqyqTrCVWeORaw2t/NObJ3ZAHUMhjdKmo3cmESdgi86e2IMwlqn+G
 BUCkxUMpW3COdG6bpcnl5fAuDg6gNwHsIYOUeav2OfpglU+l271kd9ALSeMBWM0Si8gDL/LEMsT
 uPbH+cjoRRjIJqeMUrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNCBTYWx0ZWRfX7bl4MC2CkEZz
 hA7LT6xU3Oy82Ju3mDp4scIxJCOZ+ypMuHGqjQTcf67or2YO6cq+jZjcnS0sfvwAHdql9E8o/pK
 Kmk9XJNY0eCx4xI+WqO/Ro7mroMcVxM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070024

On Tue Oct 6, 2026 at 9:19 PM CEST, Niklas Schnelle wrote:
> On Mon, 2026-10-05 at 14:03 +0200, Tobias Schumacher wrote:
>> If per-CPU airq_iv allocation fails in the loop, previously allocated
>> vectors and arrays leak. Add proper error path to release all resources
>> on failure.
>>
>> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interru=
pts")
>> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
>
> Had my bot review my reviews and it noticed that this is missing Cc
> stable despite having a Fixes tag.

Yes, this was intentional. The leak only happens if an allocation fails
during boot, which would make PCI unusable anyway, so I didn't think it
qualifies for stable. But I wouldn't mind adding Cc: stable if you
prefer.

Thanks,
Tobias
