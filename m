Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5D3DA7E4;
	Thu, 15 Oct 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052148; cv=none; b=IAk4xfsBVNYelxqLt9ruvaTWG5SgxsUCkft/dhin/zfJX0MFET4o5qEh0Ax+CIxghGSi7bdTSLSUX/gxvN+yO1ZMg+AiEGwaqngYHCvZDw32cbWsYHO5XKg5zMAenUYVP8C4xy6jR397ZafNQddlO2H/j2c8MV8bfSKs2B9h7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052148; c=relaxed/simple;
	bh=yRKC3OiOVGxe0cIdFUNCe2UZElMZPZSIJ4hszIoKg/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh6zwBekIcIrOY0LYrh5EI0m1fohFXvgIRreen5a/BoI1sBU/D8Uq/SD9o9deAD6GIZqnMuuLdVyI/fp+eHMN0vOISv8NtFYH88IbILJtm9BCkSKfDl//f1s4pC0g+YbkCDEulDdzI5x+IasTJmFLSdV+B2yMfdcLKq0y7MiM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J6iU9DJ0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J6iU9DJ0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F23AwY1270180;
	Thu, 15 Oct 2026 08:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZWsJ8ZoxuWNRnB4IdC5wU1Kj/rrd+y
	hR1yrTDeCiKyU=; b=J6iU9DJ0Naym5BtA0Ja3XS2UU8O9EGZKMeTyrUXRp98rNY
	Q8IAGIUJWxcm+fCv9UqMMKPgOP4ukl4t99kpLwv/RfF5GDPwpO46UvVed2lRfhpJ
	fFOCjmE4QHbGdsOqeltLtGigx8mRff1Zli8xCjy9M8PBS/aDVWAB6kctJ9g7BhKp
	CGsk8qkRTFgD+GMkkUGYRx3ZOSsZDrNYbldBKqOhGxE1LUtr9lKWH5i7vq+Kby6h
	tZ+AK11+LyW/4XTbizfwGy0gX2QmYWvYxOk4IJSJoFt1gOE//hBTL894SeSmhXkA
	usbUee8PUIrXGlKKqb+r9Ft+DFU1+FI30bHR02Tw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0r9ea-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 08:15:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F4x04W3639750;
	Thu, 15 Oct 2026 08:15:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg6dan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 08:15:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69F8FbuM16122274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 08:15:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9D82005A;
	Thu, 15 Oct 2026 08:15:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4798320049;
	Thu, 15 Oct 2026 08:15:37 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Oct 2026 08:15:37 +0000 (GMT)
Date: Thu, 15 Oct 2026 10:15:36 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>
Subject: Re: [kvms390:queue 20/21] arch/arm64/include/asm/sysreg.h:182:10:
 fatal error: asm/sysreg-defs.h: No such file or directory
Message-ID: <20261015081536.993956-A-seiden@linux.ibm.com>
References: <202610150332.4CegXzzq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610150332.4CegXzzq-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMiBTYWx0ZWRfX4gla/vSToMnH
 YtrkYfhfmiMV5VWWX2L3gWRUMQgh4+7YooejglPyzvmt/aQ/892owoSBulh3ZVKvF1xJSBsOBq/
 5SzeKdRn6RGBicvdwPOXSZYPRMKVQxCQBoOqdp8Xd/x60LWI2wpHavP/WqdS0yG7GoAjXGaZZgk
 gbBjLnNvj1LcPiWy6pNk0e3Ko9SKAtFNAuxmPihMQiswVDMsaxZWCqfvUAmrXFJ6DkatpSZTJdv
 RAWKGADt7vln8BInbZn19njsehdIxZpdTlqM2d30OuSZ9ne4SROL/9gUjkCTJ9oqeDPJIGHRgnr
 vXYVOEQ1bX+AjAkA3NXSpDc0SX1tnC5zK/HzhC0rClSBHVKq+3dV+b7+NTWle6zSToOLzffYrc9
 vq0HBdzS9qNVyfccr3ddEF1jqtgkOwTZE7DTyjVDATvONmDZ2C7hjPKhngODRZ0lKWBy5xnE/eq
 V1Yj3qHgIuHGE9FLsow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMiBTYWx0ZWRfX0oqz2LVsaybe
 s80TY+zDICAbv4OuRSGgtteFE+VFBQgI61ZZ07A/cgdC0RP4D5F6SWb/ZTEdHKDujDho9f2RMR8
 0NPWy1FFOlqFaArj4En7WEmMrLIDCL8=
X-Proofpoint-ORIG-GUID: z1TVbS9unSXEs4GZeZUqRBkrImdz5fO9
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ad08baf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=7CQSdrXTAAAA:8
 a=SJwXSWTpRhrIunM-wUIA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: z1TVbS9unSXEs4GZeZUqRBkrImdz5fO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150032

On Thu, Oct 15, 2026 at 03:34:10AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git queue
> head:   74153e116543bc017aff93720fcc603cb0e8598c
> commit: 325380d8e78936b65d30e29d6be478bdd03c87d8 [20/21] KVM: s390: arm64: Integrate arm on s390
> config: s390-debug_defconfig (https://download.01.org/0day-ci/archive/20261015/202610150332.4CegXzzq-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 16.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150332.4CegXzzq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202610150332.4CegXzzq-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/s390/include/arm64/sysreg.h:11,
>                     from arch/s390/include/arm64/ptrace.h:6,
>                     from arch/arm64/include/uapi/asm/kvm.h:37,
>                     from arch/s390/include/asm/kvm.h:3,
>                     from include/uapi/linux/kvm.h:16,
>                     from include/linux/kvm_host.h:40,
>                     from arch/s390/kvm/arm64/handle_exit.c:3:
> >> arch/arm64/include/asm/sysreg.h:182:10: fatal error: asm/sysreg-defs.h: No such file or directory
>      182 | #include "asm/sysreg-defs.h"
>          |          ^~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>

Somehow expected.
This tree misses one fix in arm64 code that was already picked by
Catalin via the arm64 tree:

arm64: Use proper include variant
https://lore.kernel.org/all/179026581764.3570880.1246463318810507401.b4-ty@b4/

Steffen

> 
> vim +182 arch/arm64/include/asm/sysreg.h
> 
> 7c9cb893ae3e06c Marc Zyngier 2025-04-25  175  
> c07d8017bceb82c Mark Brown   2022-05-03  176  /*
> c07d8017bceb82c Mark Brown   2022-05-03  177   * Automatically generated definitions for system registers, the
> c07d8017bceb82c Mark Brown   2022-05-03  178   * manual encodings below are in the process of being converted to
> c07d8017bceb82c Mark Brown   2022-05-03  179   * come from here. The header relies on the definition of sys_reg()
> c07d8017bceb82c Mark Brown   2022-05-03  180   * earlier in this file.
> c07d8017bceb82c Mark Brown   2022-05-03  181   */
> c07d8017bceb82c Mark Brown   2022-05-03 @182  #include "asm/sysreg-defs.h"
> c07d8017bceb82c Mark Brown   2022-05-03  183  
> 
> :::::: The code at line 182 was first introduced by commit
> :::::: c07d8017bceb82cbe5fedd129d072c59a53f5513 arm64/sysreg: Enable automatic generation of system register definitions
> 
> :::::: TO: Mark Brown <broonie@kernel.org>
> :::::: CC: Catalin Marinas <catalin.marinas@arm.com>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
