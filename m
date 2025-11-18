Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62936C0C6;
	Tue, 18 Nov 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490667; cv=none; b=m20haG+q0+MtbF7+cG23MTgPKWwgEqbnnbcMJlikfdAYSy/JcH08precl7Q2U9Uw/9gKF3CR0z1Y6LpTYSg65OS/YkEFf+M9yHiVgqbumPtP2tDdJZlCybLEq0UYwYMDDG3nEp+vdd+slSrI7DfweDTdG5bllfssSBgYaXchOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490667; c=relaxed/simple;
	bh=qra0LmHUrRfMJKHykiWacyJfv07Pn9BVvd3ADIKrMSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE+xjctnf6xnP59+FMoI1lOF92CnopJkaWSWjzWztxpArOHf6Hoi7WCiTSf0KID+1M5OlND+IwdApAW7WTHM7VVfQ/kKOsHIfkCPE5QGh02kxzp87FN1Qo+gZlWhDP49EgIe9ATHDSL3e4Lih1Tm0iEUXPvpJQ/sIlXwirdgJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qj5DopK4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qj5DopK4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIH6gAw013243;
	Tue, 18 Nov 2025 18:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5fjJGshdLgsM5CNcFRWv6U7zxv4KuS
	mk9nKok2NYDZY=; b=Qj5DopK4LIqCWw7qciEClKYBiFwh93uVV4RVxxl1Z1jwKg
	IrPqlglcrhqnIyxAkr/epHZUiPTXbhDCFivvjIYQ/63RMrNBIfFVWUroOCJUQKPs
	Zr/sMbHJQaYwCKACEo18N4BinDJzxsTGwJD/C++PXxE5AKjdL1DQQ/71jKTYe2gV
	t8YwZe1zgvW2AtOixXxOWPD0IZLwwjY/mEIOpvNWuag8zGAeWP0EdJL7Li0zoJL1
	pk0n+Yq2H8Ns/5LYIbR4vUAuy0xayDHibliyuuE5WY20u0Bh/J0rWasNd6k7eXLX
	OTk005d6YyCrmkiUq02dmFmNB/ugKYfRtl3H1AAA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsm5jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 18:30:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIFjKBS022354;
	Tue, 18 Nov 2025 18:30:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umvndc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 18:30:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AIIUn1355706034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 18:30:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BBD62004B;
	Tue, 18 Nov 2025 18:30:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB1D220040;
	Tue, 18 Nov 2025 18:30:48 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.80.237])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Nov 2025 18:30:48 +0000 (GMT)
Date: Tue, 18 Nov 2025 19:30:47 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <aRy7V8EF6cRj8lCo@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117124359.75604-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FTmH5ViG_qAK9d6uPJyfa26V_IUg95FY
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691cbb5e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=x4DeSrqng6IWvJ6sItAA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: FTmH5ViG_qAK9d6uPJyfa26V_IUg95FY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX/nAP4cJPyEVa
 R72IUMm1jd4zQwWHHz+u4VImYq+a/nUAmH284R7QDYFdyXosrq/iwGZ0tz3vYiRks2xKpiSKAPg
 7Kf7cYwEycIgToXedbTmrs8C6kEoyMTp77uVUZypJjiV7b8S7CL+k2TvC39Y2JpzKRUrbpLLZw6
 YaGvzRSeZlAY1OKx9sohwTgYdICMktYuzlcRKoJoBrV9l8AAJCGzyhH6RCfL+pEbNybkiLwJP/K
 g7ukjzApQbJ5JccGnvKKV1XT0MqcwrdrqTFnseUvGvS+YvKmU3QbvaMiMoVtDVmpCYIwTQ/cLlE
 dVeAh2VGaW7Qnjb6bhdRC4puURWlDAOZMJ8on71gyWg/0meWaL084xtc1tvAw1mFjjZ8qu7UMgU
 0paJmbCH3/I5AfIZnIEkHzv/caG6qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Mon, Nov 17, 2025 at 01:43:59PM +0100, Thomas Richter wrote:
> The following test case fails on linux-next repo:
>
---8<--- snip ---8<---
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> index ef2da806be6b..9cd6180062d8 100755
> --- a/tools/perf/tests/shell/trace_btf_general.sh
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -39,7 +39,7 @@ trace_test_buffer() {
>    echo "Testing perf trace's buffer augmentation"
>    # echo will insert a newline (\10) at the end of the buffer
>    output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
> -  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
> +  if ! echo "$output" | grep -qE "^echo/[0-9]+ write\([0-9]+, ${buffer}\\\\10, [0-9]+(, ..)?\) += +[0-9]+$"
>    then
>      printf "Buffer augmentation test failed, output:\n$output\n"
>      err=1
---------------8<---------------
Tested-by: Jan Polensky <japo@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>

Thank you Thomas

Nit: maybe `(, \"\")?` instead of `(, ..)?` for clarity?
