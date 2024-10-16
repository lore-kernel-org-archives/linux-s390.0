Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE252071F0;
	Wed, 16 Oct 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074068; cv=none; b=JLwoNeQD6eOa7WtuXVtR8Rf6OmKCbBLKUmgqu0ocPWeFfod2Kr14LAxydi9wCcu0cRWMjGP64/yvcEXBRtSay+Kkr7pWGoL3j/2SLpxnN68cs5I9OWractCKWx0IuaUqOouiTrNM7cTPdQHli7keD9yVvn0hnEIjX7FJj8v4mrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074068; c=relaxed/simple;
	bh=H1/K1KID8HpD2RgHEh9C2izUYqHtfccu2ecCI5oxUKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5NbRkxFX2dHWt3TktVeN8xiyqP9kxyApCC4n/pZNqSZZ3Tu1mxwD+1Inz+54hWLadEGHhthvOzA5NMPTnReiek65m6y8NBS4IiZLkQUiODUZYuJN3JznO8gFAwbrv4z3Ll8moFlOpjei7SjCLECdLyzo4hk7nyig8At2LQZ6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EF+TxwdN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EF+TxwdN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAK5h7022175;
	Wed, 16 Oct 2024 10:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CUvXBqMiYzYjQoWQ8TF9UcJDXxCLJM
	NMr/BZna+RnNI=; b=EF+TxwdNUN5arWarc+nO029oqee0EB3UOFHPb3sHzcxAUL
	lrRCfRBwag4rf+qDobqzaUzQ6R/MhE9FI6eMRrEb+Kq3u/M8uEMsP+lx7Xn1tTLc
	THPLsfRbYv/fVHCCBe4arBZqZjfwhAQVCE9ZVENDJHZAFblxc1v/nj4JpQo7MUFZ
	uUONW8CESK851eeL4ddHmqDEsEFe+9+iJFK5cFBhDZIcvz4zl3xwq441XfG9ZzDV
	wAaeNnkTD5CehrLEIsOwWMhvQIoFViRzDytdMMkQ+W/ehj5OgBN5ztOGHQG7ZqrK
	GFdl5lFV6MUkjGHgXzAV2dyJiGiFoGuZZ2LhTNlw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42abn0g064-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 10:20:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GAKqv0023595;
	Wed, 16 Oct 2024 10:20:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42abn0g062-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 10:20:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAAIcf001982;
	Wed, 16 Oct 2024 10:20:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emrt16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 10:20:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GAKm9D22675726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 264A120040;
	Wed, 16 Oct 2024 10:20:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D1682004F;
	Wed, 16 Oct 2024 10:20:47 +0000 (GMT)
Received: from osiris (unknown [9.179.27.227])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 10:20:47 +0000 (GMT)
Date: Wed, 16 Oct 2024 12:20:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] s390/time: Add PtP driver
Message-ID: <20241016102046.16801-C-hca@linux.ibm.com>
References: <20241015105414.2825635-1-svens@linux.ibm.com>
 <20241015105414.2825635-4-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015105414.2825635-4-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NPlmDSFm1ey-6X5lNcO78OPOBXgpMpwE
X-Proofpoint-ORIG-GUID: gO7apGrsTiHf2-Kzu5yWMzUw6kmuZs5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=868 lowpriorityscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160063

On Tue, Oct 15, 2024 at 12:54:14PM +0200, Sven Schnelle wrote:
> Add a small PtP driver which allows user space to get
> the values of the physical and tod clock. This allows
> programs like chrony to use STP as clock source and
> steer the kernel clock. The physical clock can be used
> as a debugging aid to get the clock without any additional
> offsets like STP steering or LPAR offset.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

...

> +static __always_inline unsigned long eitod_to_ns(union tod_clock *clk)
> +{
> +	clk->eitod -= TOD_UNIX_EPOCH;
> +	return ((clk->eitod >> 9) * 125) + (((clk->eitod & 0x1ff) * 125) >> 9);
> +}

This is quite odd ;). This helper modifies the input union, which may
be very surprising to callers. It subtracts TOD_UNIX_EPOCH, which may
also be surprising, especially since we don't do that for tod_to_ns().

In addition the input value contains 72 bits, while the output value
is truncated to the lower 64 bits.

From my point of view this should look like

static __always_inline u128 eitod_to_ns(u128 todval)
{
	return (todval * 125) >> 9;
}

This way there are no surpring semantics (at least to me), and this
is more or less similar to tod_to_ns(). Since there won't be any
overflow with the multiplication it is also possible to simplify the
calculation.

Then it is up to the caller to subtract TOD_UNIX_EPOCH from the input
value before calling this helper, and the caller can also do
truncation in whatever way wanted.

> +bool stp_enabled(void);
>  #endif

Besides that there is an empty line missing before the endif: why is
this in timex.h and not in stp.h where it naturally would belong to?

> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
> index 4214901c3ab0..47b20235953c 100644
> --- a/arch/s390/kernel/time.c
> +++ b/arch/s390/kernel/time.c
> @@ -469,6 +469,13 @@ static void __init stp_reset(void)
>  	}
>  }
>  
> +bool stp_enabled(void)
> +{
> +	return test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags) &&
> +		stp_online;
> +}

Make this one long line, please.

> +config PTP_S390
> +	tristate "S390 PTP driver"
> +	depends on PTP_1588_CLOCK
> +	default y

Why default y?

> +static int ptp_s390_stcke_gettime(struct ptp_clock_info *ptp,
> +				  struct timespec64 *ts)
> +{
> +	union tod_clock tod;
> +
> +	if (!stp_enabled())
> +		return -EOPNOTSUPP;
> +
> +	store_tod_clock_ext_cc(&tod);

Why store_tod_clock_ext_cc()? This doesn't check the condition code,
but generates dead instructions (ipm+srl). store_tod_clock_ext() is
probably what should be used here?

> +static int s390_arch_ptp_get_crosststamp(ktime_t *device_time,
> +					 struct system_counterval_t *system_counter,
> +					 void *ctx)
> +{
> +	union tod_clock clk;
> +
> +	store_tod_clock_ext_cc(&clk);

Same here.

> +static struct ptp_clock_info ptp_s390_stcke_info = {
> +	.owner		= THIS_MODULE,
> +	.name		= "IBM Z STCKE Clock",

Please use "s390..." instead of "IBM Z...", which is the architecture
name within the kernel.

> +static struct ptp_clock_info ptp_s390_qpt_info = {
> +	.owner		= THIS_MODULE,
> +	.name		= "IBM Z Physical Clock",

Same.
