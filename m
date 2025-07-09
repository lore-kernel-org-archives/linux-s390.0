Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71199283FE4
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052965; cv=none; b=u5wD9WoBLz4e4ixRkeFkFlx5mxXMxgnQC1Ch7xUQc64x+tx8AWn95/vGKmrRg4vzEb6LMK9TikouWHK87Hk2J35NTVj58fhLZLMMaNy7PWbLFvDV/GDCRHnoe4QEjfqBO4pDpYQ+zI7+vVtz2RSLS/vFdTCQ7revfYBVwgXBeVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052965; c=relaxed/simple;
	bh=khBWoBaapCfzb38aoltOmtEbuHuOhGnsNE2GqUMjO10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1ayD7Dt8Z5wfbD+/6vim8Ljhby2t2+EdhqRD4YZ/OJdAws6GrVHW3dhUjK2UkHJHBjWC03ISnVGEmzbbnZAln6KC5tfxxObkPCgXjqJu99wvUMkhWNP+RXVV8iKpTuRMRcKwpOBALn8/E5SFWyAq7PolBvRwPDONRfzb+lI2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EAWQRFJo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EAWQRFJo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5695kkdD002270;
	Wed, 9 Jul 2025 09:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZW3+v7
	Hp5kAkNfcdJMGkO8A/4SmVmGMVcoBv6qkdGrQ=; b=EAWQRFJov+Lk+Wvx+scmWG
	+Fwi8+ektFoOBjzXhgf7+VrkC/hl4p3eOH98rFlgDsMIBf1nggzwFXSQNykHvEWD
	mZh0qnKR8pooscxDQNCfDgV3NyPxocmj0duoWmX+0OSt2xdO67Pr+Hl+TjKtaqQK
	KAAR+7YOZlBVx7+B26Mj43fWYhyP1GPMlLfIGqFDvnsmlHo2Ej6gshGM0SIBzsoZ
	za/NtvoTcYi/pV74pZSp+msU/HJ4pA8JJsEom2QnKA0nocUwsaSfP0N2Ptceo0nf
	2zILtPic+IPGTUnBp0xunpLtQ2YFnAtCMmVA0uXL6ieyKpj5Ax4zRpxRjfaKsgoQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur75a9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 09:22:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5696FKVc021522;
	Wed, 9 Jul 2025 09:22:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectqp3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 09:22:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5699MT8W46596442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 09:22:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DFBF2005A;
	Wed,  9 Jul 2025 09:22:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53E232004E;
	Wed,  9 Jul 2025 09:22:29 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 09:22:29 +0000 (GMT)
Date: Wed, 9 Jul 2025 11:22:28 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, nrb@linux.ibm.com,
        david@redhat.com, thuth@redhat.com, alexandru.elisei@arm.com
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix arch_cmd
Message-ID: <20250709112228.26a548e0@p-imbrenda>
In-Reply-To: <20250709085938.33254-2-andrew.jones@linux.dev>
References: <20250709085938.33254-2-andrew.jones@linux.dev>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA4MyBTYWx0ZWRfX8HpvQQUkoe5F +SoaKTIdt6UoULHwDp9S54GMVmWCJe1crOlvRM18NGMfEe0QX9E4DveIbAkwtQVxHo++hu+8gyi zhsWNazfH9NstA+/27bl9MKhurXiJihdENuZZdVXwJNROKg20uPtG7XF8zAJSLsPnKqWqPW7U4T
 yAcP7Rlr1QCAy+sdyVYDMVMgZ34s+0ntLOkTvZsuIORUuNi9zWjJmKN4wGD7MBgBm8VWOj1ky7M lawoP8cmgA88HIuO3RGWKaONQCwRB/5v5r2VVzEsqKPbauKIA3aTTYPb8WyEvXTbIuJpsX70ql7 fv39j/rFkyHpHIhbff+g1lS6WwrEOUbRLvWYFpLgmnrZUEVF4o3B+OVJXWV4FY2yvv33kcyLRl8
 5IxjNfoNxcvrOTdbcp1jnpBlZaRYfWKyYmVhLv2znbqrFawuzZA8qVbMQzhsF+eFJPP82kdE
X-Proofpoint-GUID: i9ovzqOiLJt5U4jqmcJSY2gulFHczvVB
X-Proofpoint-ORIG-GUID: i9ovzqOiLJt5U4jqmcJSY2gulFHczvVB
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686e34db cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=R4wX1_-xBgTt3nXO3IsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090083

On Wed,  9 Jul 2025 10:59:39 +0200
Andrew Jones <andrew.jones@linux.dev> wrote:

> As commit ("scripts: Add 'test_args' test definition parameter") states
> in its summary, it adds another parameter. Make sure we account for it
> in the s390x-specific arch_cmd as well.
> 
> Fixes: a7794f16c84a ("scripts: Add 'test_args' test definition parameter")
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  scripts/s390x/func.bash | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
> index f04e8e2ac0a7..28c3a70c7da9 100644
> --- a/scripts/s390x/func.bash
> +++ b/scripts/s390x/func.bash
> @@ -11,15 +11,16 @@ function arch_cmd_s390x()
>  	local groups=$3
>  	local smp=$4
>  	local kernel=$5
> -	local opts=$6
> -	local arch=$7
> -	local machine=$8
> -	local check=$9
> -	local accel=${10}
> -	local timeout=${11}
> +	local test_args=$6
> +	local opts=$7
> +	local arch=$8
> +	local machine=$9
> +	local check=${10}
> +	local accel=${11}
> +	local timeout=${12}
>  
>  	# run the normal test case
> -	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
> +	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
>  
>  	# run PV test case
>  	if [ "$accel" = 'tcg' ] || grep -q "migration" <<< "$groups"; then
> @@ -35,5 +36,5 @@ function arch_cmd_s390x()
>  		print_result 'SKIP' $testname '' 'PVM image was not created'
>  		return 2
>  	fi
> -	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
> +	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
>  }

