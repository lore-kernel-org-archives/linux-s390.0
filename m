Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07B25B1CE;
	Wed,  8 Oct 2025 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923231; cv=none; b=BuQNK0ybwrLdasDrgDWupu1UxjeKIBKNIxoyyrEYkWUd/57m/nCuqYyOcUwa8tSlSQhvR3m2ty1sAMSnQk06befhbooP8KhIglH23YXlMfa4hVV4hC8NgrJ8wq/GBhGnN/HJwgVpgGA208do1vKcUN1wORTy+7FvW3Bp5/xZimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923231; c=relaxed/simple;
	bh=L+2fye9Ib3uD7MA5+gYMRyxRvD/TWeTC7y9dz08Bbg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayfwL6uuR+u94u3WE2CZs4wJdNVtQuMlqwiSEfDTb2VCy0brxuRFckT3F0ynzlDQ4bO5iFRSJxpqtmD4SjGjjxAkP6p19GFxHQTfB4Ywsn9MzlRWbN0DBD/ucEX1K8CVpR1+rlxlhlrJkkSldEtGbseZiJhCQxQDqz0h1Lam0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AtK9X9C3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AtK9X9C3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59861pUM029541;
	Wed, 8 Oct 2025 11:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cD3doI1H992VZmrJzuQPrEJS+17cAj
	SZhV0T++OnTuU=; b=AtK9X9C3Ow8g/hEwl6h7ITycgam7duPhYdM9lnTT+JsWgC
	u5Xx/tcuse0TvtQU42l694n2sf1uCp/xpKz6Knvb1D6empHE9JcFBMKzaAmxf5QN
	o56WTyv/poJotU4Pp2bzAKtoqKOldAt/DxIpRvSPIt7OV+QMR6X3SYTpVuax2KTL
	EZEMyMeiSJxaBD0VwGK6Ju+nNMp5AnczNO6IWqY9/q1zj1OkjHIqE/WrmWP9iRsJ
	3QIEAj184PkyTfO9TGkqlINyislDN2C56M6DW2ZxtJhB1z3rNL7nRinIuwKcGl6h
	sg2ltlIDwBfZeRgexdHSya1bLKEmJ/g8yAaEi8pQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pm3u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 11:33:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5988hjtM019689;
	Wed, 8 Oct 2025 11:33:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kdwsgc8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 11:33:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598BXafL33030406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 11:33:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0072C20043;
	Wed,  8 Oct 2025 11:33:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A900420040;
	Wed,  8 Oct 2025 11:33:35 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 11:33:35 +0000 (GMT)
Date: Wed, 8 Oct 2025 13:33:34 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Alexey Gladkov <legion@kernel.org>, linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ben Copeland <benjamin.copeland@linaro.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: next-20251002: S390: gcc-8-defconfig: symbol `.modinfo' required
 but not present - no symbols
Message-ID: <20251008113334.7407C2a-hca@linux.ibm.com>
References: <CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com>
 <20251006174740.13659A33-hca@linux.ibm.com>
 <20251006234114.GA659425@ax162>
 <20251008031849.GA509861@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008031849.GA509861@ax162>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e64c16 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=4v_5KyVoQ7rjD2eOJY4A:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Z5es2m0Zpmw3MsLdk9wrrvwrgOmkI3m6
X-Proofpoint-GUID: Z5es2m0Zpmw3MsLdk9wrrvwrgOmkI3m6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX1/jZo+hW4RQw
 rHPbC19ae8AC+H9fY8sU9Knms6+6DtsqjRQNBao+9+ZGxu5Qc5XoMw7cxHOQkUgCfob/rffCYjZ
 sef+XIxUNayA0fzw9Vb6z0zcW157wyFkpnJgbdyOV30Yg2so0zwKo3pasD1SZ2kK+d1+1ocdcO+
 E3w17j3Hys9dZkYoaW+LEdHNYPR8HJLzFcPlTwhGm53Gpv414obggcOJgWn3brGAeKzOQL7uAUr
 EVo93LNqTOKyhH+Rp8uV7KBSQinRkvk12v6FuyC7u2d6dYiHSPIoxWvSV3gWwA8i1U2WME08YTh
 ylNb0N6EeibUQZIb7ggF4/lWw1ic28TwoBtrc3vCeWkz2ToS3NXoE4lv1QIPWtPvxGQFBlsQjkI
 U9WrWw2hwk7/8f6R3dB6Hr/JmFWwiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009

Hi Nathan,

On Tue, Oct 07, 2025 at 08:18:49PM -0700, Nathan Chancellor wrote:
> On Mon, Oct 06, 2025 at 04:41:19PM -0700, Nathan Chancellor wrote:
> ...
> > > > ### Build error log
> > > > s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section `.got.plt' not in segment
> > > > s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section `.got.plt' not in segment
> > > > s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section `.got.plt' not in segment
> > > > s390x-linux-gnu-objcopy: vmlinux: warning: allocated section `.got.plt' not in segment
> > > > s390x-linux-gnu-objcopy: stM7JmYX: warning: allocated section `.got.plt' not in segment
> 
> So these warnings should be fixed with:

...

> I am unsure why newer binutils does not show this but I did not care
> enough to actually bisect.
> 
> > > > s390x-linux-gnu-objcopy: stM7JmYX: symbol `.modinfo' required but not present
> > > > s390x-linux-gnu-objcopy:stM7JmYX: no symbols
> 
> I did bisect binutils to figure out that commit c12d9fa2afe ("Support
> objcopy --remove-section=.relaFOO") [1] in binutils 2.32 resolves this
> error.
> 
> I can fix this for those older binutils with:
> 
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index 7c6ae9886f8f..9ea92c3317dc 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -82,7 +82,7 @@ endif
>  # ---------------------------------------------------------------------------
>  
>  remove-section-y                                   := .modinfo
> -remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*'
> +remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '.rel.*'
>  
>  remove-symbols := -w --strip-symbol='__mod_device_table__*'
> 
> I can send a patch series tomorrow.

Thank you for figuring this out. Highly appreciated!
