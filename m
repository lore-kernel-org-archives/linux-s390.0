Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB33CB56A;
	Wed, 30 Sep 2026 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795835; cv=none; b=YwhIqpwy5/QiYKGwal/wvDf1xS5qOnl3Xt0I0y2SAOYmoyvVoQy60pMvnnXGZQsa7aQJv+vseAMmVVUpmN04iDD69cfsmy7Xk1e3YgZLyUPXqUEkFctnxYVWYRiDJvPsAqfNMJXemK2RaQCsmS73w936cbbhTK1kImSKHOgfE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795835; c=relaxed/simple;
	bh=9sy2qAbznoyLBvlyj1OFwSgpoBIUXjLMmKAdCHsacJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRzltnvM/lXPs7+eIFlEDjtjEQ+fij5YSNSkHCSYdhFSGxpk8t6dyhZEoqOj1aZU/Wh/XbYrRYw1Nl6eIHtzI5RReIhHUxZTGfj+GFSMUSpUx4QM21lLevnTMBZ7/tTLMl9mW81u8wF0Cm530pMEW7WqLrrENPstbSrS4PW42wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FQXBhRW+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FQXBhRW+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UI5UST1841061;
	Wed, 30 Sep 2026 19:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L9Ur5P
	6PkDeQGBnQEP8zSTezBYCW0d+jds49X044s/M=; b=FQXBhRW+r6xF2j/hEv4NoU
	ycb8TBUfk+ASSA+zzhzl+sRKG4612PttvSTX8gAcLbYgkI00vimzygxUsNmy6/SL
	yYEdUn6I9zZjVSC7UwOao7sYg2h9GalXOKBVF2YUPS+J7ttAbsP6QgQ/SVgZu8jY
	mfV3du08LvWc1KQjE8sw6SVXTP1OXqBh4ivniQTjMGrHyELdz5806Gy2mouLQn7y
	ZMrKJnBdqQI5GQUxSZciW1woB7Bo4/YcszaQuxRpLcYle7SNeSGJEcK0eDRy214U
	3MFDsMIDglRaRJI2uUBL3wCmwR4rVkj3vFt4sg4Fi0dZboqiSvcHCGO9bsvItDBQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrf1g8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 19:17:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UI2MYt3863800;
	Wed, 30 Sep 2026 19:17:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsak8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 19:17:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UJH9Vr27853360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 19:17:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203FC5805A;
	Wed, 30 Sep 2026 19:17:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B53258054;
	Wed, 30 Sep 2026 19:17:07 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 19:17:07 +0000 (GMT)
Message-ID: <d85157b0-1574-4ac5-9fb4-9dc86c2530df@linux.ibm.com>
Date: Wed, 30 Sep 2026 15:17:06 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] vfio-pci/zdev: Add VFIO FMB device features
To: Alex Williamson <alex@shazbot.org>, Omar Elghoul
 <oelghoul@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-5-oelghoul@linux.ibm.com>
 <20260930125750.7a5bc3a8@shazbot.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260930125750.7a5bc3a8@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3OCBTYWx0ZWRfX3HXaLWT4j6Ze
 MJW2g4Y7O2yHH/Gta+XAWqw5ZEsqw/lcXr4klKE6aTx7iPPfK7m5TmTmO028MutJn4yCDif9k46
 8dI/C9HWFIni1OQlrSP4Kh7KA3IyUv+2L9f+DUWGS4TEp7R65tUShljXHxqXNIPRCmFaPeVOSl5
 zfToNr0lHRKpjmVkCCojAGCRs1uauwCVUIPWHCZVd9Krh0LUom4+IqAhGTg3s++QPlOnkIdZzuW
 JFnS1GkzQBJjS6xXuncy8obu5l1zMCyILif/vq1a69WedzCVRQ335sTmFefujop6zsIf7Cd7ZUm
 115EZeDb3x30hrlcjjc0+VREKGRNpt0ffwPFQ/CozBWa/MhiPsCGEL1VO0kRAF1qi97NjtTGxBw
 hOyzAbi4OFIK9JTTIJK3Doz/7765NVG2DunrH+biEAsQcXT6yI7+SgGBOHP77JJDrPXfKXS+6Ji
 MfXtf3mHkBhDhd9btyg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abd6037 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=hCghWN36U95Y1TgLiSQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8nnwSJ6qE3Q8YvO24gu_vyOax_ONoS5U
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3OCBTYWx0ZWRfXxZiy1p1tYkdq
 EPVFGbsZpe+/v+isjyJbk3cg7pP02PihmBaxggQcxEjErQRVg0+gmD25mPlmmKy40HnaV+xUvTe
 kXrLt5UwcbEVtMe6seopMJ47CxUX5eQ=
X-Proofpoint-GUID: 8nnwSJ6qE3Q8YvO24gu_vyOax_ONoS5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300078


>> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_READ 15
>> +
>> +struct vfio_device_feature_zpci_fmb_read {
>> +	__aligned_u64 data;
>> +};
>> +
> 
> As usual, feature numbers need to be coordinated with the vfio tree.
> What's the merge plan for this?  Thanks,
> 
Looks like some s390 KVM maintainers weren't on CC, added Janosch and
Claudio (Omar please make sure to include them for next version)...

s390(-kvm) maintainers,

Do you think you would take this via s390-kvm (or s390) with Alex's ack
on the vfio parts, or vice versa? (Please note: this is not yet the
final version of this series)

For perspective, the changes are mostly in arch/s390 and the
s390-specific vfio_pci_zdev code.

s390 changes:
 arch/s390/include/asm/pci.h      |  2 +
 arch/s390/pci/pci.c              | 85 +++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c        | 11 ++++-
 drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++

VFIO changes:
 drivers/vfio/pci/vfio_pci_core.c |  4 ++
 drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++

Thanks,
Matt


