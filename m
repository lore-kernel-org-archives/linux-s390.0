Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9676258EF9
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388248; cv=none; b=XqTHHePRsdZnpthgI503oSu9t744IKQvmSZHb8jjhDK8/Jue7KUnjmVN8fQwPeYlFSglK5IPyY7ZBDc15ePdd6adVQxKtbXsEvqUIaHdyHxfocww3JbllgJPpO/2FlJ7WFs64IFVSQstpvpazfnljMYXW3MG12IPy8C51Y6MsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388248; c=relaxed/simple;
	bh=VxzLlfKrz61tXZqXsbJ0R2NhEsCkP0lLU4O9eGHeq/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7Nvm4NwBgmgJhQ5LzaDXSX2CmAsNCWCVf+bTbzBgaLvtLpJHkK8qqgxpq7pHJS17fzVG9PT0Q2WeGdnoegqryNBD+QdPljfixi5CGZ7QBFNIsmD7QgQkslfZDsKTik76s/dylj85DLXxFR8cAwvIKKSV7NjD4qvCas9wVjQKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kzz5JRK+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kzz5JRK+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EA1WNf4027139;
	Mon, 14 Sep 2026 12:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UF0ZQa
	CMx2yjHDNquUhBVGPpnoPq/zrXZHe2VagGY9U=; b=kzz5JRK+PBUL3vvEHz7v0G
	jnthNSA6kYlo+UQK6764+rqmx9/vu8Wo6Uy9GWJvjdoMBDRDEZ3dqgbX6AFbuJ1b
	gK8AjeZ5fRnGquMRjP3B60gYvn7h6rguLDjCy4rrMorNZDHQONQ0GNs1b5Au82Rs
	1M5mWbUdBCQPp+w3mzRjbUT++WfG4QDPuutJuMeNtQ5cgycyfqcQyIqXGibqQZ9G
	jj4NHuovALOICYozTSmbEaK1hhCnjLqNCwMfeFbdM/Ds66VLjzMw6UNa4LWBEktw
	0mndyOoEGt44tvBdAiCIkZRC9gLkgBK2+oGmKe5oFIUp0zYyVuAKc/Caa+z8yYWQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq1820-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 12:17:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9o4qO2106320;
	Mon, 14 Sep 2026 12:17:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2px2t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 12:17:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ECHHCV51642824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 12:17:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29A6A2004F;
	Mon, 14 Sep 2026 12:17:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF63020040;
	Mon, 14 Sep 2026 12:17:16 +0000 (GMT)
Received: from osiris (unknown [9.111.83.12])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 12:17:16 +0000 (GMT)
Date: Mon, 14 Sep 2026 14:17:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: wbezenah@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com, oberpar@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] s390/cio: Harden pmcw/schib handling for dnv=0
Message-ID: <20260914121715.39845Ba0-hca@linux.ibm.com>
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910093205.3357827-1-vneethv@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX5Vd9Y8rPbDZZ
 iUgYQD7PUaFkbAdeem8bBImxEofhjBiO3cZ33cFtPUyQ1vNpZPMXO14lamq1RVc+I2EPMWVMCXp
 S+yVLbiT2NU3XXk3T1IZNRi6nuDD97i2zmdIn+UQt0CxOH4dMG8oUVXxbRaA8OdKELelxO3hghr
 7TaaKDMWFsBRtKeIVFmLnGAY7rLnzF0zOIGDRPZst7+KgLFOKW3tl7ez2swla7ZxoXvRXliRhnQ
 5nYKEMb6cCL38oBy4ntN4RazRLLpfoRDNrmQoHE/ePBSK/c5L6eY+OOC+HIzxMAOsdw/vEAM/+c
 dXoTVnhor5ctC68+8vaI9R0DADn4K9SIoX2bcBSE9wiZnfwgiJlihLn3SqxZ6TzD/A1iaEUmwXs
 7pGwEXyRg0nyX9zPdmnURCRSfRNdN6SXlfCCSY1RBDHaer6SX5mZga60bXQNgZfXqfVxoROX11f
 Fny4XBIsC20eCDMx4aQ==
X-Proofpoint-GUID: Omv19irjmql1phXwwOB7AqR6cZRqJDus
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa7e5d1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Dd6p6baFu_z_ejji7pMA:9 a=PRpDppDLrCsA:10 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: Omv19irjmql1phXwwOB7AqR6cZRqJDus
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX36kYuD6ZKNI+
 Z3sWnrVv1/GgntfZIGQVpo5WVJQXHECdTIQQKjZ0E/uelnT9GZy6LOQG1pu/KhRYjWK6wDRBVHy
 aOjfEgd0Blqv1QoQSTXrcJXe4aD1ask=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140171

On Thu, Sep 10, 2026 at 11:32:00AM +0200, Vineeth Vijayan wrote:
> For I/O subchannels, pmcw.dnv must be validated before relying on any
> other PMCW or SCHIB fields.
> Two issues exist today:
>  - Some I/O entry points check pmcw.ena without first verifying that
>    pmcw.dnv is set.
>  - cio_update_schib() updates the cached SCHIB before validating
>    pmcw.dnv, allowing an stsch result with dnv=0 to leave stale or
>    undefined data in sch->schib.
>  
> This can trigger spurious, non-fatal error messages in the guest kernel
> log when a virtio device is being detached.
>  
> Fix this by validating pmcw.dnv before updating the cached SCHIB. Also
> clear the cached SCHIB when stsch succeeds but returns dnv=0, ensuring
> that stale state is not retained.
>  
> Additionally, add pmcw.dnv checks before pmcw.ena checks in I/O entry
> points and return -ENODEV when no device is present. Guard remaining
> direct accesses to cached PMCW fields, such as chpid[] and pam, to
> ensure they are only evaluated when the SCHIB contents are valid.
>  
> This was reported and discussed at:
>  
> Link: https://lore.kernel.org/linux-s390/20260612155407.199218-1-wbezenah@linux.ibm.com/ 
> 
> Vineeth Vijayan (3):
>   s390/cio: Fix cio_update_schib() to not cache invalid schib
>   s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
>   s390/cio: Guard PMCW field accesses with dnv check
> 
>  drivers/s390/cio/chp.c          |  3 +++
>  drivers/s390/cio/cio.c          | 11 +++++++----
>  drivers/s390/cio/device.c       |  9 +++++----
>  drivers/s390/cio/device_fsm.c   |  3 +++
>  drivers/s390/cio/device_ops.c   | 21 +++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_fsm.c |  2 +-
>  6 files changed, 40 insertions(+), 9 deletions(-)

What is supposed to happen with this series? Since none of the s390
maintainers were on to/cc I assume this is not supposed to go upstream
and can be ignored?
