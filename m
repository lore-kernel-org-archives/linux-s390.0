Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B413215061;
	Thu, 17 Apr 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890738; cv=none; b=UambGLveOwKNGoXL5XJJl/Cq+rRd6nbM185pAf8C7zCeO0plbGmi+lxVlT33eijCLkuoN5T1W+UN+jDmFOFiZ+5j8t813OHtbE8YpJmdqbMZua8c44zq7zlWOhnf5dns5ZMvSHaPsII/wZ+bUMeoh/AZC77BjcE6UtTILHQ/mVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890738; c=relaxed/simple;
	bh=TiDNvMnp0IugLxAqC2JocJtrOHqZw8rkUQ+/eq3NByo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpKZukr2H43qv1725G4Wk5w0xSeeBBYYa9XBMflHOoBUv48GPREjW46/MR81gYcrE8uOIVh0UnhHrxx9e90lFgLCAM7xz4rL8F4BTh1CNgz7CM2EVuJYsBqLW8VZf+ODLBDPhlP9iPNJhil4L57KZY/zV335p9AdMrLuCC2vi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Izcs6Pd+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Izcs6Pd+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HA4B0q002812;
	Thu, 17 Apr 2025 11:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ur8BoTvqIlCkziFmeuS6AZYBF/JO6n
	z1/deh12WLJkQ=; b=Izcs6Pd+/XtYuSOI6JkebZQtpiR+k9Ax1z8ZMfAgWQdoYf
	68Kujc65cPNNUVk8HsLdVUvBxeA0VTL8tskF0Qk3T6KZeT9Qqqn+VSWgIE/SAlMh
	dbhpRDDFv//G3Ftx8kSSpGKJ8AS6Aw6VngkqtPVhsrqVk7R3qI/v5mBEgEnw4PnM
	Oze9xfOT8YNLjrxN5G1Xqyx5bIPFG1RwJbAwetLLRdnrdFFoSgwNghxGm+SSDDl/
	KeLMcwdCqDNexUe35y8hwfeMi7pY6qUf1uDTz3z8URb4Nq0OxzKPDljWTAAh8joy
	W1AW/VFYmSHHHFJAaPT112ht/mDZGC8M1Rkp1fJg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462yjj8f8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:52:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBUjh4017195;
	Thu, 17 Apr 2025 11:52:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m5c57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:52:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HBq6YX32768416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 11:52:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9DEA20043;
	Thu, 17 Apr 2025 11:52:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E3F420040;
	Thu, 17 Apr 2025 11:52:06 +0000 (GMT)
Received: from osiris (unknown [9.87.137.75])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Apr 2025 11:52:06 +0000 (GMT)
Date: Thu, 17 Apr 2025 13:52:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com
Subject: Re: [PATCH] perf/tests: Fix tests 84 and 86 Add --metric-only on s390
Message-ID: <20250417115204.12521Ef5-hca@linux.ibm.com>
References: <20250415134553.3089594-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415134553.3089594-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3T4M7v_4x5QBVKGq313W6NGnx1rRdfNb
X-Authority-Analysis: v=2.4 cv=MsNS63ae c=1 sm=1 tr=0 ts=6800eb6b cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=pkdV3G2aDOTQtP1BiC4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 3T4M7v_4x5QBVKGq313W6NGnx1rRdfNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504170086

On Tue, Apr 15, 2025 at 03:45:53PM +0200, Thomas Richter wrote:
> On s390x z/VM machines the CPU Measurement Facility is not available.
> Events cycles and instructions do not exist.
> Running above tests on s390 z/VM always fails with this error:
> 
>  # ./perf test 84 86
>  84: perf stat JSON output linter          : FAILED!
>  86: perf stat STD output linter           : FAILED!
>  #

I would guess this fails also for KVM guests?

> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
> index 4d4aac547f01..a708dedf7d9d 100644
> --- a/tools/perf/tests/shell/lib/stat_output.sh
> +++ b/tools/perf/tests/shell/lib/stat_output.sh
> @@ -151,6 +151,11 @@ check_per_socket()
>  check_metric_only()
>  {
>  	echo -n "Checking $1 output: metric only "
> +	if [ "$(uname -m)" = "s390x" ] && grep -q z/VM /proc/sysinfo
> +	then
> +		echo "[Skip] not supported on z/VM"
> +		return
> +	fi

Wouldn't it be better to test for the availability of the CPU-measurement
counter facility? That is: test if facility number 67 is present in the
facilities field of /proc/cpuinfo.
