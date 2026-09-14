Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10E42EEC9
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404197; cv=none; b=g1ujbXY70o9DJkRLyO9O16sOeZ3kmXBN/m+EgBBZm2fDJKi4yWiRt4Afxn+Xp73BpqJdB7Q1DvmFrIg9kYxZMeODSTYFHfHtX4Vgwn4ZE2JEvHFiEnu2EGOEQT0h9LDzEy6rlBd2d1P9cdwM2g/O0yXWvyGx8RJECq/IA0Ohwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404197; c=relaxed/simple;
	bh=B+LGQ+TgXqfa3zGTOLjzecdt+2tb8qjnTPtWFw0Nzo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmSj/EHw1Oh05Kp/NiFuruu7a1oDPD7q61N6nC/5zD3bD5aLmfUrwT/Ey3FDuBmta7MW10f5cWAIN0mQqux8pM0X/GqBhEa02zdw3TspFp0deEFhvLeXhcJxZid8zoGaAz3/A4ESSw/77m64SiAEvZg5+1SCtKXtAFqM4fMh2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ctv5XB8z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ctv5XB8z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFwN741322309;
	Mon, 14 Sep 2026 16:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U9fAtQ
	tmT2wdLM0/zI+OnieIae6PRlnBIfTWm3ojzrI=; b=Ctv5XB8ziXMsjumjDlf6i/
	YcSOmdd3ldLhZzgjnZzoHBYJUIBQwtSSX8sW7FGGCArTt+Rv29X8BpnYWfn0s00s
	T9/q1Vt9C8eRJgHTmXvl2SWbpUmsTIySsUzlPLlFERdTYhbUhumtBTEkerMT6QHg
	i5KZX5kd/X1C1hD3f6XzHd5+BRM2aSdsEN4pYnXhtMPl7E9CgKRM7jgt6f1TLy+9
	0Q8RvtNh8QFZ/xoH1g7wd7KSjlMG+IW9NUu4naOnkQEMrrZKctOyLCzM64izqJ0d
	AWWwdnQSprS7UpOiB2C5krDCOHz8QAPD6pmexPQ4CrH+pOhLsVzhBoi2KFBqTaQw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dtmwk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 16:43:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGVNsx2359957;
	Mon, 14 Sep 2026 16:43:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2py82s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 16:43:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EGh8HD39780754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 16:43:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 975702004E;
	Mon, 14 Sep 2026 16:43:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4816A20040;
	Mon, 14 Sep 2026 16:43:08 +0000 (GMT)
Received: from osiris (unknown [9.87.150.220])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 16:43:08 +0000 (GMT)
Date: Mon, 14 Sep 2026 18:43:06 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: wbezenah@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com, oberpar@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] s390/cio: Harden pmcw/schib handling for dnv=0
Message-ID: <20260914164306.14910C66-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfXz9eh7azriaTH
 M0y+QCGIURWQnMhZwwTjg7gEMXG4LBYT4p6ApZKsjnU0ah4D0FF3HOpHweQNnsiRLF+HXAQS2bM
 +JkzCkn0W1SFfOUuSTbHs4N7A0kDfY8TpIs8ZDcHIx+ba+XrgWe8A0iPRQ1VXRfq4pZH34saeyq
 O1PqEEHr8xjjGmkNRFOhJUem+6pVi+zBq+jMcrDS3GCrT3SuS86IZm4Hm/ZfAnpskJtF7MZKwNA
 QPN2lnqVFxKyjYmualkHIfdkYXOWI4L2mLeBQU7YOr4WENibB0dvkZhI8VpS4z3dZQreQyCtnXh
 eL7O6EkWnKr8/KX44bQZeUuCK3OcXiNCFNdKhpUZyp7nTJHTcY0pPyPAfUJKb9KFDA/R8hYIT1B
 HzalsoLcVvfi/umy+i6uOPCi7DSJibn8dLhCnJs+de2mnm+MDwvk8hNFoeKtVW4rCEnHfFsFG8J
 FePB1MXSMMf4GlTuEUA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa82421 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Dd6p6baFu_z_ejji7pMA:9 a=PRpDppDLrCsA:10 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: QYfwgCmeHAVTteuuqjEWsZLm_6UeWDIF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfX+qGQaTkBx3GC
 d1BWQ3vvPsrYigSD7Zzy7njb40u/gQ4NlOgeVjdtxFXOrwNYHvBbA/bOvCDK0sQa8WM5fVYPsPK
 NqqpT/y2fjyKDf6K89HWQ6JgJ8hkTTE=
X-Proofpoint-GUID: QYfwgCmeHAVTteuuqjEWsZLm_6UeWDIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140237

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

Series applied, thanks!
