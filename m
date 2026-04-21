Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570F18C2C;
	Tue, 21 Apr 2026 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769758; cv=none; b=AsbE0vp/QGkbmYT0o7J+b9NnYzwHfNt5hmSvTolyW7RiZTfK9BqajtorAzt/Mzq2GhoaXMfrdZD7di9GICt1wnwkbhMjBjH/1DuFS1EQ32xtdQJKW3LcCl+VqeRzSLK78qUVHctRGLXj3pO136m27J+PAPfIdVschTWOyTGWL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769758; c=relaxed/simple;
	bh=ZaFzwhI5D0yrKjew7bD34wpRzka9op8Csqy0dnZpv88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YamXvNbitMaj53u2n3YQXGrloAAI1YWYf1pnoB9/QrdVmWmtyapM02U3QQIu5T6SOTGPlmEY5dnGVnOPACIlGIrqbWSna9zMOzsOx5UuQnLMLqLIdHvgKDliQcWVOSJjXqU1IQQfY/kY9oBY/h+lMTT+D4HT07akPpVY7Jep71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BR+v63Lt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BR+v63Lt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgpkV1926413;
	Tue, 21 Apr 2026 11:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T3H91b
	sDL7/xhYYkryX7fNyKY9SgdsJH4b+GuaHgfMA=; b=BR+v63Lt+Qkxa9PVdPnqTu
	hqTEUY06ImCZoxDc/kH8Dx70JMd3JGvU4gVTreS0QVMLlTukxn7J8YqNg5SFk1JX
	HPuxv41DLq3de+4XL1L1NNmXsAdp07ExkEZczsQV/v+Z8mrkVHo4fFwZ4NedUqT0
	yYirImNR8miGWaV6iRq0A/q0gf8T86tqPng9rKQxX88kjqoWECyI7FGsU+BihGbe
	sOzC9qH9jijjQ/cmiENXuF9WAZXelUM5vn5XmQ2OoFLBL4AbaM5u4/9zJCB765Nm
	7Myb1Ic4wO6QD1coa3TMTvQ3NK524H33OOQiTy3ywCt9wMhJc0n997PaiWTSD+EA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf3yev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:09:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LB5TBt005992;
	Tue, 21 Apr 2026 11:09:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsh0cch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:09:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LB982q23658790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:09:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C784C2004D;
	Tue, 21 Apr 2026 11:09:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DF7620040;
	Tue, 21 Apr 2026 11:09:08 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:09:08 +0000 (GMT)
Message-ID: <02a6c0b7-7e57-49a7-8542-1800f3077e4e@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH Ping] perf test: probe_vfs_getname add do_getname() probing
 fallback
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260416125515.3481495-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260416125515.3481495-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _ftDUXaLcLmue2heY_Qnb6uke_pFfVIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEwNyBTYWx0ZWRfX14Qy875k6p8n
 XMosWxT+hsEraPwrDr0S5AG/5nYF4XQxJzVZwgIPgiY+hVI0eKEEwcsKpKsGwfL7GPn5C3zQOrC
 HqoyKfN0SYQ/KiV38lUIMRlQxXBcrTnW8Qquc+h0sxtBEto7TPJoiNfOhnnmj4RvC1gCakmB1mI
 H8kftnC65hlvcj5P+gNUw6YYop3Fvi53Yh9EoB++ON76T8aTEPIPFBd7/nzZsxuXQmdEdSt1MbA
 xOmJJc7ADhZ9VMaQeJaBDqVOWN7TbxxftCVGs5jg5Yvkh/m7+hCoH7qMWQRNWLfugmZLTsSg4wz
 Xg9nzNn2Q1T0MKfTPzGrK7xuGCWwhICRyOTI/4/yEVnImXfsQ0S9qnapQXQLZUGhtcbxPwlt5C6
 g8mlDq2CSmT9Gm+SMP43k16D3aSAWwFfveLtCvl0oQU/RmOorzxhRn6Iv4V3FgpE7mz8uFmWqHH
 mYQLjpBn89Ec3GNjpNA==
X-Proofpoint-GUID: _ftDUXaLcLmue2heY_Qnb6uke_pFfVIt
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e75ad9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=KByoUL483hSIROooWq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210107

Friendly ping...

On 4/16/26 14:55, Thomas Richter wrote:
> The following tests are skipped for some time now on platforms
> s390 and x86_64:
> 
>  # perf test vfs_getname
>  138: Add vfs_getname probe to get syscall args filenames    : Skip
>  140: Use vfs_getname probe to get syscall args filenames    : Skip
>  154: Check open filename arg using perf trace + vfs_getname : Skip
>  #
> 
> This is caused by a change in kernel code of function
> getname_flags(), see
>   commit 9fa3ec84587c ("allow incomplete imports of filenames")
> This commit changed the function getname_flags() implementation.
> 
> Now the perf probe 'vfs_getname parameter=xxx' does not match any
> more. Extend the test logic to fall back to probing do_getname().
> This reflects the updated kernel code.
> 
> Output after:
>  # perf test vfs_getname
>  138: Add vfs_getname probe to get syscall args filenames    : Ok
>  140: Use vfs_getname probe to get syscall args filenames    : Ok
>  154: Check open filename arg using perf trace + vfs_getname : Ok
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f6..9156a79212b9 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -12,6 +12,8 @@ cleanup_probe_vfs_getname() {
>  
>  add_probe_vfs_getname() {
>  	add_probe_verbose=$1
> +	do_getname=0
> +
>  	if [ $had_vfs_getname -eq 1 ] ; then
>  		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
>  		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
> @@ -28,12 +30,24 @@ add_probe_vfs_getname() {
>  			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
>  		fi
>  
> +		if [ -z "$line" ] ; then
> +			do_getname=1
> +			result_iname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname\(result\);"
> +			line=$(perf probe -L do_getname 2>&1 | grep -E "$result_iname_re" | sed -r "s/$result_iname_re/\1/")
> +		fi
> +
>  		if [ -z "$line" ] ; then
>  			echo "Could not find probeable line"
>  			return 2
>  		fi
>  
> -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> +		if [ "$do_getname" -eq 1 ]
> +		then
> +			param="vfs_getname=do_getname:${line} pathname=result->iname:string"
> +			perf probe -q "$param" || perf probe $add_probe_verbose "$param" || return 1
> +			return 0
> +		fi
> +		perf probe -q "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
>  		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
>  	fi
>  }


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
