Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4930E0EF;
	Tue, 21 Apr 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771936; cv=none; b=D0+s9aZAAeXHzuH1zugEKZ2ni0yYMvFg+qtfyxFRgU2auIqaczXqqZnpqDl2s7DTjHpk102hl3pLVtGh4AJX774KR1mgjnF94LFgh3vlZK1r5bxNWKfyBIkGUoDEnJCnofyAeRdzPqlOHF++d5UtJKnRmZYvLtEF+AZFdkjb0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771936; c=relaxed/simple;
	bh=oc3DT0RAljxYhphvFjljrtFnjvK3CrrN1ZikMbdQvq4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=XqPJ4h/nFmbhS5L9sJb/AK2N/PzFNpfPdLsbUurCwU3R1PGGVmHpzlcHJ+n274SZ/qRjVqG7UwuFRMtulh3r0Ff9LjQZJa5yS7HKLEM6TSCcfee80V2/EbJFAohgOgTOkzjLWk8w0O3cQupecPjrXRRgs+xd3aQZJkOu7k4vBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hHREpEKG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hHREpEKG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgWHd1684519;
	Tue, 21 Apr 2026 11:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sc/iHQ
	ObgvqaXJQGcuitJQ9rZ8MJtG8DUciKwJ454XA=; b=hHREpEKG9mE10X6YC/1fn8
	vzkwPuRm2ZVq6l7K1l1IJ1PZ6zQw/u1zXwu4TQ7FowNctCnZMN8bbj/j7a4DRHqH
	ZAYtaihPbICjgWIvlStZ+7Pi0Uhx66cc/WxKDWYbbIVq0Sq2es/ejij8nSEmAhr/
	1Gbpr+Jhfi1lRXs9QXE5PRuZHyl/ul9HuMAOYhPyENd034ZFxpVrjxmv6cPpGp5H
	jcfZVV3wLCiSMeLUUS+SJsGn8VsKufWJsgqfTZDJTxKxHXjOVI9yCb/smrNOZq3e
	9CQqleGp1rOWCkdWpSls+86FkdEVt/yQXBaxi+9o+aH/67LDlgZhw3PEfmcZ35dw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6m253-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZVlq027137;
	Tue, 21 Apr 2026 11:45:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy09bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjPuo51249620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBCED20043;
	Tue, 21 Apr 2026 11:45:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C681C20040;
	Tue, 21 Apr 2026 11:45:25 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:25 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 13:45:20 +0200
Message-Id: <DHYT2W2J6ZEK.IPC6QH99OSQF@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth"
 <thuth@redhat.com>, <kvm@vger.kernel.org>,
        "Nina Schoetterl-Glausch"
 <nsg@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: Add test for STFLE
 interpretive execution (format-2)
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-5-5e52be2e4081@linux.ibm.com>
 <3e7d74b9-f5ab-4461-a6f4-2f917c869996@linux.ibm.com>
In-Reply-To: <3e7d74b9-f5ab-4461-a6f4-2f917c869996@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfX6kAbReRI7JIc
 WabxUVz9oaHs4Szw5YvrvpzXy8jKBh/ZsDvi3QZsUVESxci5HN1ZqifbS4P3CY9UMJiIIKi0ohX
 PICUkb52UK80UmCdOc9bqOz1uJOoOcuPI3WhrXPZb85lzhhBeU85uERoZTirINHDffbz4jcrgVf
 E1zPJDHtUmck3IfhszaAB0i7+OYlWeECyJREsMbn1vsBFcxlQOEnX+AYeS81zEDZndHco8496pR
 NZX0/349pKhqFZbDzB5fXman5i26MzyPXrn0ywMK/h+zE2Vs+a8YbgyuP8UF9YSOeBXFZt1/X5s
 o3dOcO+fNzCLukXq8yrNRUCpWhupW5crF+6te2VIwdTVBfYNua6ctvbtZzfuD2/7jUCvgfVLPWm
 4UmPT3nJOoD2EGvmK3yiF1W707dH/OGUxIf6PuEDu+qddCGjA+vVZu/oM4YM0BHZThKb6jhskE0
 qMWKTbWPIPMn1QMidpw==
X-Proofpoint-GUID: mJGBn9pacc6CmbVVZJyGTTnM6GPp2Nuv
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e7635a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=cN4iABI9U8P0S6PSPTIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mJGBn9pacc6CmbVVZJyGTTnM6GPp2Nuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210112

On Wed Mar 25, 2026 at 11:18 AM CET, Janosch Frank wrote:
> On 3/24/26 16:28, Christoph Schlameuss wrote:
>> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>=20
>> The STFLE instruction indicates installed facilities.
>> SIE has facilities for the interpretive execution of STFLE.
>> There are multiple possible formats for the control block.
>> Use a snippet guest executing STFLE to get the result of
>> interpretive execution and check the result.
>> With the addition of the format-2 control block invalid format
>> specifiers are now possible.
>> Test for the occurrence of optional validity intercepts.
>>=20
>> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> ---
>>   lib/s390x/sie.c   | 11 +++++++
>>   lib/s390x/sie.h   |  1 +
>>   s390x/stfle-sie.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++=
+-------
>>   3 files changed, 92 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
>> index 0fa915cf028a1b35a76aa316dfd97308094a4682..17f0ef7eff427002dd6d74d9=
8f58ed493457a7ce 100644
>> --- a/lib/s390x/sie.c
>> +++ b/lib/s390x/sie.c

[...]

>> @@ -55,18 +56,73 @@ static struct guest_stfle_res run_guest(void)
>>   static void test_stfle_format_0(void)
>>   {
>>   	struct guest_stfle_res res;
>> +	int format_mask;
>>  =20
>>   	report_prefix_push("format-0");
>> -	for (int j =3D 0; j < stfle_size(); j++)
>> -		WRITE_ONCE((*fac)[j], prng64(&prng_s));
>> -	vm.sblk->fac =3D (uint32_t)(uint64_t)fac;
>> -	res =3D run_guest();
>> -	report(res.len =3D=3D stfle_size(), "stfle len correct");
>> -	report(!memcmp(*fac, res.mem, res.len * sizeof(uint64_t)),
>> -	       "Guest facility list as specified");
>> +	/*
>> +	 * There are multiple valid two bit format control values depending on
>> +	 * the available facilities.
>> +	 * The facility introduced last defines the validity of control bits.
>> +	 */
>> +	format_mask =3D sclp_facilities.has_astfleie2 ? 3 : sclp_facilities.ha=
s_astfleie1;
>
> Without the KVM patches format_mask is 0.
>
>> +	for (int i =3D 0; i < 4; i++) {
>
> Why?
> This test is only for format 0, no?
>
>> +		if (i & format_mask)
>> +			continue;
>
> i & 0 is always false.
>
>> +		report_prefix_pushf("format control %d", i);
>> +		for (int j =3D 0; j < stfle_size(); j++)
>> +			WRITE_ONCE((*fac)[j], prng64(&prng_s));
>> +		vm.sblk->fac =3D (uint32_t)(uint64_t)fac | i;
>
> Since my mask is 0 and i can be 0 - 3 where values >0 can lead to=20
> validities (optional) this test can run into a validity at any point.
>
>> +		res =3D run_guest();
>> +		report(res.len =3D=3D stfle_size(), "stfle len correct");
>> +		report(!memcmp(*fac, res.mem, res.len * sizeof(uint64_t)),
>> +		       "Guest facility list as specified");
>> +		report_prefix_pop();
>> +	}
>>   	report_prefix_pop();
>>   }

[...]

>> +
>> +static void test_no_stfle_format(int format)
>> +{
>> +	reset_guest(&vm);
>> +	vm.sblk->fac =3D (uint32_t)(uint64_t)fac | format;
>> +	sie_expect_validity(&vm);
>> +	sie(&vm);
>> +	sie_check_optional_validity(&vm, 0x1330);
>> +}
>
> This needs a prefix, right now I see three of these skip reports and I=20
> don't know which format was tested:
> PASS: optional VALIDITY: no
>
> But looking at the code above I wonder if that should be folded into the=
=20
> test above if the logic is fixed.
>

Yes, I added some prefixes and reverted the additional loop from
test_stfle_format_0() for v3. That makes the log nice and readable now.


>> +
>>   struct args {
>>   	uint64_t seed;
>>   };
>> @@ -119,20 +175,33 @@ static struct args parse_args(int argc, char **arg=
v)
>>   int main(int argc, char **argv)
>>   {
>>   	struct args args =3D parse_args(argc, argv);
>> -	bool run_format_0 =3D test_facility(7);
>>  =20
>>   	if (!sclp_facilities.has_sief2) {
>>   		report_skip("SIEF2 facility unavailable");
>>   		goto out;
>>   	}
>> -	if (!run_format_0)
>> +	if (!test_facility(7)) {
>>   		report_skip("STFLE facility not available");
>> +		goto out;
>> +	}
>>  =20
>>   	report_info("PRNG seed: 0x%lx", args.seed);
>>   	prng_s =3D prng_init(args.seed);
>>   	setup_guest();
>> -	if (run_format_0)
>> -		test_stfle_format_0();
>> +	test_stfle_format_0();
>> +
>> +	if (!sclp_facilities.has_astfleie1)
>> +		test_no_stfle_format(1);
>> +
>> +	if (!sclp_facilities.has_astfleie2) {
>> +		test_no_stfle_format(2);
>> +		report_skip("alternate STFLE interpretive-execution facility 2 not av=
ailable");
>> +	} else {
>> +		test_stfle_format_2();
>> +	}
>> +
>
> Does this test work on LPAR and zVM?
>

Yes, it does. I did test explicitly on zVM now as well.

>> +	test_no_stfle_format(3);
>> +
>>   out:
>>   	return report_summary();
>>   }
>>=20

