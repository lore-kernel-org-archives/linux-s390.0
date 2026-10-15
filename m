Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FEB51DB14;
	Thu, 15 Oct 2026 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068117; cv=none; b=XFEo1TlGJKl0/5m0KR2OqLK3QJll+k6sCLiIa8dzmMFAcXJbIJY+RlhGqzcEK4kuNVm+dqPj31Jc4xrgoGEySIflNDcYn++6v1BICQ2x9Qd6/vuMiuNet3EXifLRaoiighxe/aLXglLimvqdlseTxot8t0qlAuKfyGfyazilY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068117; c=relaxed/simple;
	bh=SNTyFLAn6X8MzFPAuEPiRWOhyQiyS/CoxgKgSZbJyjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg4Fsgb/kgx4Ug9NuX//Cy2YH3HlXT1oY/F4ix88OBmnvOIDtco9w50KLFKVQhHroERAqMYKTnMLiCIb6EPmpv2FWZdSelS0O2F46X1XoqjlrEQfoUl98xYIcMj/rywhgm2OgVKodFdZvIoddjImZ+53oBVAfHcnbtdL4vt7gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hI7PD8pw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hI7PD8pw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kFT5575165;
	Thu, 15 Oct 2026 12:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Cz6qmyFdfwa6mhs4MvWn81RB7DZBab
	J18bLGUjLxMeo=; b=hI7PD8pwlID9Rb+1F/57jpvpduHZa2/wTuvMdITRxNNbO6
	dGvmdSow9Z468uy33pWo2bSmW7/GacFX4r8iGtPllGJVr5glHHkPSAfFnrRFzGiA
	4edSRrW12T++zTDe+AX6pFj+5rSvyinSxCsnb2N4w/n2l4/acPC6mVRf0eH2FPJr
	pg8JHliqN79ZFn3sjdFd9Ej0CUScbIFFeUGx3MFcXVR7V3Hgz/paRD+i4sLQnWBl
	oAaoWfvHfeECPFkePBuxGZDw/UUx5UCL8g1y+QVhekdSbA0ExIpk4MlZUn9Z16yt
	H7AMAHNDTSRHU2SiMBP6kJjIGJMUjVOU85S9349w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wh96c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 12:41:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9ntxl1929670;
	Thu, 15 Oct 2026 12:41:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3sqg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 12:41:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FCfmwL31982194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 12:41:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A678120043;
	Thu, 15 Oct 2026 12:41:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D9632004B;
	Thu, 15 Oct 2026 12:41:48 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Oct 2026 12:41:48 +0000 (GMT)
Date: Thu, 15 Oct 2026 14:41:47 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: drivers/s390x: select uvdevice tests using
 the target architecture
Message-ID: <20261015124147.1310928-A-seiden@linux.ibm.com>
References: <20261014200149.1365017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014200149.1365017-1-sashal@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfX/PLAKWP2tibr
 abMVrbM50y6r9zNkjYH3HpZkE+idX3x7a46nEZ43S/C+/EPuU+TfQV3w/pvKRpytfv2f1RuW5EP
 H/f94GzwYFmUjd5lJxXCLud8A76Sw0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfX0J6VVWgVuf+K
 7clyeUD0eG/wYISHwp0pjdkQg7pelcZA8GcG2lIi/+OSYqOSdoJexZeCz91DzfV57UBVHpoicN1
 lNHNyj3Qp81tc/fEZgfPepQvHKKqSvpqbbNRkHiiN8CQU0vd9S3FZpRGueen1T81UW515Paj/1+
 SupWSaD+JL93HF6yZ3UDMLNnhVP5CnAGbB1wogoF0VcleWovW86sA8mUUWMNSoxL6uWvI/6jHi7
 tUHdhU9elwA1XS9C0ca2Dzq01La2R4l7d+6jNZ2laZOhkmskLowhJjvIhFBE6SlkTfSXEATlePE
 /GmQxR3MjPUGxGgGCaomkvg0b8Jo3VlG1G/xvK2rPDSZs81eAXIVHKYhhVzLhGdtET9FZzv9j4z
 kYXLv5F6dee2kTydzpSJwtMnItVO+Ilw/gFQcAy3ev2M+k3kU7J1d96k+THA45O1F8Y54GPoJ7W
 mSVU/Axx1bKz9hRp8UA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ad0ca11 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7Zwrf4lqyfeLcvQkEBYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BUoFCE4ZKZDUnMgU9G-AQn78TDzN7BId
X-Proofpoint-GUID: BUoFCE4ZKZDUnMgU9G-AQn78TDzN7BId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150048

On Wed, Oct 14, 2026 at 04:01:49PM -0400, Sasha Levin wrote:
> The uvdevice Makefile decides whether to build its test from uname -m,
> which describes the build host. A cross build for s390 on another host
> therefore silently omits the test, while the non-s390 branch provides
> no-op build and installation targets but no emit_tests target.
> 
> Select the test from the target ARCH when it is given and from the
> host's SUBARCH otherwise, accepting both the s390 and s390x spellings,
> and include lib.mk unconditionally so that other architectures build,
> install and emit an empty runlist. ARCH itself is left unset so that a
> native LLVM=1 build keeps using the compiler's native target.
> 
> Drop the include path derived from tools/arch/$(ARCH): the test only
> needs asm/uvdevice.h from the installed kernel headers, and the path
> does not exist for the s390x spelling.
> 
> Fixes: cbac924200b8 ("selftests: drivers/s390x: Add uvdevice tests")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

LGTM.
Thanks.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

