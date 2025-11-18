Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDA2BE646;
	Tue, 18 Nov 2025 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446578; cv=none; b=IvxOLJ9swj15/msx7XzK8itRa4ZWaAZqRaT3kLJbE/AAsMOtGSlQOtK987fv4xat6m0/TKG0J+G9EtEuIz4ieZcfVbkTwrba4/0ks26SMaCqH1ssqzHuTOoL0Evm660G8iKcoAMhBSnrEBmfyoUDISjl06+GgK7yNnth2MIDe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446578; c=relaxed/simple;
	bh=ikht64jw6tFTIXvPMamcP2s3xNFQCt0URTs8oHcUIZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPtEyra1cAK8ak6pRW/4Er3qwFva6ALXS3rUcrgFQEa2nmyY9xMNsN4EULX++dB/ALG2okUS7neotMhqwlXMpBMucFzjrwsThw6XkZo2V9cpOOnjtID2poo28gWZbiD4hK9/oydnCmscnIB4hX1J96oV617roBsxv8Oo6N6Xc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nyONSBMZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nyONSBMZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI0beKt019792;
	Tue, 18 Nov 2025 06:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VN4tlj
	35Bva/qFUKb/pRgLpAWkm7G3IGIR43bz70jmk=; b=nyONSBMZmXGvtRH7i1Kl+/
	g+fZpZMf0M1HvhF6Kcocei76LTIhjA0SOMSeVkcLXtiz35oUcooL/sQYQuaSxMfg
	0ZxEflsKR7XMsO8AIFQQpz0oFZ1KY7jhm3Tbw1yf1nC/LKCrMDt5kwneYVq9ICWP
	oRbpFDE/8KiZRFSoDvWn2+AbmF8K171SiXiDkf1pu2pOE78QlpCA++4YgYt9twH3
	EkwrA1m/9lBszMVkZZSvYRlUsWNC4ZXcHZ4T+/Yrijw+CxX+Do6jNt/r23TBgYlC
	3SQ+8TQgqOXgA/0Qc4nLIXjc1XM/9hjz9vLqrqtQhlLZj98vV9h7zWKxcRVLKI0w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk19bug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:15:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI45dwj007134;
	Tue, 18 Nov 2025 06:15:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62j9fyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:15:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AI6FkmJ43385208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 06:15:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECACC20043;
	Tue, 18 Nov 2025 06:15:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E6B520040;
	Tue, 18 Nov 2025 06:15:45 +0000 (GMT)
Received: from [9.111.18.10] (unknown [9.111.18.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 06:15:45 +0000 (GMT)
Message-ID: <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
Date: Tue, 18 Nov 2025 07:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
 <aRvSv03cqarM5dY9@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aRvSv03cqarM5dY9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691c0f16 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=V3McCXeDXxOSx0DP5N0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: ZkYGkSFA4LIx6XSsSk2n7bwmmCaKXK6N
X-Proofpoint-ORIG-GUID: ZkYGkSFA4LIx6XSsSk2n7bwmmCaKXK6N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX7/HFs1vxlKX/
 2tuOw/bZq9MYJj4l1ms8j7PteMaOuTuaovafuKAjISLHh8yp8JwI4eW/FQeo9lKvi2a/VR/rpgL
 9x6jo86mKOMOx4KP45ydOLbCFzyQBzcFzB2lLeA6Y0E0DagXXhSwrX2hg8q3+lQiOcJJaIHmNoZ
 OuBRMkRJVf7f8TbKRupAR4NSSMLUi7qT/W5D9n5G8Ujvy7Gb8yAVjp3ZMH+ky2nxyg9M/aI+Lwr
 XS6cPdvbOQYglRT3WQTdAzUIpSaNcHxvBixfug39SsgHdVWeACM4ndCbtBR0Iy8WPHJR0doSbML
 UuYoOe/L5jM3IRtdJnE1kGQ4pQwGS9OHoZUOzPAAgrK576N60bdGpCCK2nCxIexJDkxpl0Ve8/F
 U/byyrwPvUfIJTsf3is2JRIDRfPsxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On 11/18/25 02:58, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Nov 17, 2025 at 01:43:59PM +0100, Thomas Richter wrote:
>> The following test case fails on linux-next repo:
>>
>>  ❯ uname -a
>>  Linux s83lp47.lnxne.boe 6.18.0-20251116.rc5.git0.0f2995693867.63.\
>>       fc42.s390x+next #1 SMP Sun Nov 16 20:05:28 CET 2025 s390x GNU/Linux
>>
>>  # perf test -Fv 109
>>  --- start ---
>>  Checking if vmlinux BTF exists
>>  Testing perf trace's string augmentation
>>  Testing perf trace's buffer augmentation
>>  Buffer augmentation test failed, output:
>>  buffer content
>>  echo/23281 write(1, buffer conten, 15, "") = 15
>>  ---- end ----
>>  109: perf trace BTF general tests            : FAILED!
>>  #
>>
>> The root case is a changed output format on linux-next.
>> There is an addional "" string as forth parameter in the write()
>> line. Here is the detailed output on linux-repo.
>> Please note that this depends on the kernel and not on the perf tool.
> 
> Thanks for the report.  Do you know what the 4th arg is?  It'd be nice
> if you can dump the contents of the event format which is
> /sys/kernel/tracing/events/syscalls/sys_enter_write/format.
> 
> Thanks,
> Namhyung
> 

Here is the output from my x86 virtual machine with linux-next 20251114 tag.

bash-5.3# uname -a
Linux f43 6.18.0-rc5-next-20251114tmr-n #1 SMP PREEMPT_DYNAMIC Mon Nov 17 11:24:02 CET 2025 x86_64 GNU/Linux
bash-5.3# cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
name: sys_enter_write
ID: 758
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
	field:unsigned int fd;	offset:16;	size:8;	signed:0;
	field:const char * buf;	offset:24;	size:8;	signed:0;
	field:size_t count;	offset:32;	size:8;	signed:0;
	field:__data_loc char[] __buf_val;	offset:40;	size:4;	signed:0;

print fmt: "fd: 0x%08lx, buf: 0x%08lx (%s), count: 0x%08lx", ((unsigned long)(REC->fd)), ((unsigned long)(REC->buf)), __print_dynamic_array(__buf_val, 1), ((unsigned long)(REC->count))
bash-5.3# 

Hope this helps.

>>
>> Output on linux next kernel:
>>  # uname -a
>>  Linux f43 6.18.0-rc5-next-20251114tmr-n #1 SMP PREEMPT_DYNAMIC ...
>>  # perf config trace.show_arg_names=false trace.show_duration=false \
>> 	trace.show_timestamp=false trace.args_alignment=0
>>  # ./perf trace --sort-events -e write --max-events=1 \
>> 	-- echo 'buffer content' 1>/dev/null
>>  echo/7676 write(1, buffer content\10, 15, "") = 15
>>  #
>>
>> Output on linux kernel:
>>  # uname -a
>>  Linux b3560002.lnxne.boe 6.18.0-rc5m-perf #6 ....
>>  # perf config trace.show_arg_names=false trace.show_duration=false \
>> 	trace.show_timestamp=false trace.args_alignment=0
>>  # ./perf trace --sort-events -e write --max-events=1 \
>> 	-- echo 'buffer content' 1>/dev/null
>>  echo/36932 write(1, buffer content\10, 15) = 15
>>  #
>>
>> Add the optional forth parameter in the extented regular expression to
>> accept both output formats.
>>
>> Output after:
>>  # ./perf test -Fv 'perf trace BTF general tests'
>>  --- start ---
>>  Checking if vmlinux BTF exists
>>  Testing perf trace's string augmentation
>>  Testing perf trace's buffer augmentation
>>  Testing perf trace's struct augmentation
>>  ---- end ----
>>  115: perf trace BTF general tests            : Ok
>>  #
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/tests/shell/trace_btf_general.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
>> index ef2da806be6b..9cd6180062d8 100755
>> --- a/tools/perf/tests/shell/trace_btf_general.sh
>> +++ b/tools/perf/tests/shell/trace_btf_general.sh
>> @@ -39,7 +39,7 @@ trace_test_buffer() {
>>    echo "Testing perf trace's buffer augmentation"
>>    # echo will insert a newline (\10) at the end of the buffer
>>    output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
>> -  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
>> +  if ! echo "$output" | grep -qE "^echo/[0-9]+ write\([0-9]+, ${buffer}\\\\10, [0-9]+(, ..)?\) += +[0-9]+$"
>>    then
>>      printf "Buffer augmentation test failed, output:\n$output\n"
>>      err=1
>> -- 
>> 2.51.1
>>


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
