Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090533;
	b=C5PYHVe8NPYoOjH26QrzuMTJvNt25AsB16z/9rwEygFPSc0e2Ekj+ffR1zK6HzEC12cD
	 +YSL82WtJ+Uv2Uvskq1PP/cEMMYdDLyX9Q2QgA8/JMopO9QlubFuwPDVgDcNXYhlkgswh
	 OKUmlk1tKoHxP3B6JQSndIner6jtpIcIqbemrTYqEeTahqNpJwPmKCS4DIiNYFPpjqxjT
	 hXArMNl1IGehHaCw0gi8cPhF2pXq2UaWoietTpw0AwfOFmLwT/qIqU9HvsvJqvWTtVo6S
	 JKjI5YYlNH5vF99pAckISHtMcbqn5F5WtP+YewpT4T/J8WvNgDySIMVJL3mX/gjZnew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090533;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CgFJXeqjJqdzCQvhP2yS9fqVYD+1lcromI51vnn/aFM=;
	b=MASapCHT4rFlmNd4B7891yD+4aWqmtQcb5MU7/hnbP1UqGGVUGDr2kS27twYPbBntsBH
	 qzLurowyF7O+3/UmbheE3wLkhOykyeP5wS3eyDoH5FLR+R7AjrUIIb4dcsc4KdVBA/BB8
	 cBKLejXx0zntE/xkPDAD6hM1xRi8GyEe8z+jyYHfynI3AgceifDLchqZj6QV3RjIF0KNj
	 CJwvS+iKoXPjxjmX2kK+/CHGflFLew9Sv2nqoDZlg9S1609ccReu242M+KfvAey9GQZSe
	 Vj4tuWfPlI3ZZk6eC5z6tL0VJOyJM6SH6wPWEL3KtxN21HKCT6GV2a9DjDFOMblq3nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="d5tP/nxp";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C99606A324;
	Thu, 19 Nov 2026 12:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C99606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d5tP/nxp
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBuDZ24055034;
	Thu, 19 Nov 2026 12:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CgFJXe
	qjJqdzCQvhP2yS9fqVYD+1lcromI51vnn/aFM=; b=d5tP/nxpj+3jLEaDep69JN
	zdFx4LCSmewMo5ueOv2RItRMgsSF7MtUHm2cKy4hTL8wMMd3hG9IjWQ8Gi0nEw77
	m5oNL7KO+1Q372Xw46Kk5/LARh+lLt9QK1fzLY67tPoLd7GY11A9nsRSGNtTAsF1
	P8bRzc/JWC3O1bTqxSqxjZsq3mJS3pL7nU10oNd8lhVe8MnUIGoLkfUQBSp2PlAI
	tjKsNFnaBDYjUeZciDGycxDOfmZTX/C/v0aex6rBJL5bd8nq7rIOte/AXWbAOVyh
	AH0g22jD4GTvW/DMmixsKbhK75y7eObyIt2OeVLdP5Ak0e419j5HMmg/9TsDTa6g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x0kj7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:14:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBo1Jv812713;
	Thu, 19 Nov 2026 12:14:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6v6ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:14:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJCEp6C25494216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 12:14:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A35B58059;
	Thu, 19 Nov 2026 12:14:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A0615805E;
	Thu, 19 Nov 2026 12:14:48 +0000 (GMT)
Received: from [9.61.98.127] (unknown [9.61.98.127])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 12:14:48 +0000 (GMT)
Message-ID: <aca4e70b-3a8a-475b-b2fb-ad9d1a44f254@linux.ibm.com>
Date: Thu, 19 Nov 2026 07:14:47 -0500
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio: Allow untainted use of driver_override
To: Alex Williamson <alex@shazbot.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Karl Mehltretter <kmehltretter@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Marco Elver <elver@google.com>,
        Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        Jeff Layton
 <jlayton@kernel.org>,
        Bradley Morgan <brads@mainlining.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Pnina Feder <pnina.feder@mobileye.com>,
        Mete Durlu <meted@linux.ibm.com>, Aaron Tomlin <atomlin@atomlin.com>,
        Rio <rioo.tsukatsukii@gmail.com>,
        Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linux-trace-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261119051507.3306075-1-alex@shazbot.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20261119051507.3306075-1-alex@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6jdBM5Nsu3v9NjV347NG8GEwW16sxsNM
X-Proofpoint-GUID: -Is8sDl67eNE4Ph3U6oVoO0OSRsRBGd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfX98L9DeOl2848
 Dq+aaDMU8l2HkawJgni92nfgQqMoCkshde/NbrGfSc+tLTISgwf7RF+AmTeYSEFy7pIKa3XEpG7
 4vDgzlHZXqTQiu5gIlKAJeJ4AJO0v0IVg1O7kY0wK6sRf0xTQLV4FzZDzoXtFm5SeX8dXGndTaG
 OAcina7KeNk78dTu++w9wyq0RMx8sPt1wCHHn0WoEETII81ShpqchRYe46gWufnkknJEkL5wT/3
 QByQYoe6g0ks5hLtAuojkS9jKmAyM7R+/ENl+RWWFcLyedYptF7Q1c9+h6nu5FqbiqvprOjhRxz
 Fh1lKtd1tTDPWK7v+36ctUp8rdEAFjJ+et0YBTYv0Fv/wEtUV7HfmeOv+CsonsabqgUupEt/rM8
 Wrdc2gq+Bx9brY5zpLF7FiVz/K+K74xPpDTJIwRk6uhSk4SgoWoR3k+1ixDSZ4+e+63W+MlWuu3
 9LgHdGJVzepC/wqcrFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfX0O17A8gTVimo
 kNA5kPEltyUBepHk4HkUbQZBB+m4ZnK3No1lQZDY7ASn/IeUCXtaTsLybySDIz7e7uYeXjvs06C
 o9xuhvyyMQQeQ2v3Gx5dROcrRcRAh5c=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afee83d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=gDYNflvPqbsmVAx1gOsA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190047



On 11/19/26 12:15 AM, Alex Williamson wrote:
> The vfio_ap and vfio_ccw drivers bind devices through driver_override.
> With the introduction of the support_driver_override flag in the core
> driver struct, it's now required for drivers to declare themselves as
> driver_override compatible, otherwise driver_override bindings will be
> denied or generate a kernel taint.
> 
> Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
> structs.
> 
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Jason Herne <jjherne@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> ---
> 
> Uwe, this should complete the vfio drivers needing driver override,
> covering the s390 specific drivers.  Thanks,
> 
> Alex
> 
>   drivers/s390/cio/vfio_ccw_drv.c   | 1 +
>   drivers/s390/crypto/vfio_ap_drv.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 7546bd137e4e..77765cde87f7 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver = {
>   	.drv = {
>   		.name = "vfio_ccw",
>   		.owner = THIS_MODULE,
> +		.support_driver_override = true,
>   	},
>   	.subchannel_type = vfio_ccw_sch_ids,
>   	.irq = vfio_ccw_sch_irq,
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 8e69ed286bb9..2d47dc643269 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv = {
>   	.on_config_changed = vfio_ap_on_cfg_changed,
>   	.on_scan_complete = vfio_ap_on_scan_complete,
>   	.ids = ap_queue_ids,
> +	.driver.support_driver_override = true,

Does this really belong here? Shouldn't it be in struct ap_driver
since driver_override is supported in the AP bus?

>   };
>   
>   static void vfio_ap_matrix_dev_release(struct device *dev)

