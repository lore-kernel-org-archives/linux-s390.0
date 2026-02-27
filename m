Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC536BCCE;
	Fri, 27 Feb 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205280; cv=none; b=hBzyQYz9bXJ5sW+Z0MiK6c4q6taTMHAxIZ+x9lWgP4F1fFM6/diRT/2+CaCg0z9/XxWAB0xzMrzMqeDxZg+8DO1A2oGW1qqdDOD1rlaBkuXIdadAkUycOGwbHjSnGa9L1T8ZATnbUYA6oNf60Owrc/qrK4PgeXQ1Uv1UzppAvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205280; c=relaxed/simple;
	bh=G1DMBCZlupch2gywlLXnhigGXlp5/AUMJPTIf2/zl8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL+Qu0o2stB+aHT4XdbE5B8QuSKpfbnTwN6eG/iM9ab0mlOywArjfQZJA/8FroWYi+dPcZ+PhKpEzIbrEuyz9c4fZ0mJNBoyfioxUoBFOdLCKcGKZv8yDK39w2UTtmmfX+dBN6PwPWYpI2lLokWV5+kJGVqMtHknDwKWNgxa3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCTh0ROF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCTh0ROF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61REYGqc1136392;
	Fri, 27 Feb 2026 15:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JJDWBfSNCysRUwJvl2i5MmHHSkPTb8
	ONqUHCHbTZpy0=; b=UCTh0ROF2uP873dNINdMUwKgoIeLMZ198DQ3ExuA7TX3Td
	yJ3LXkrXF0aA6oLQQpdQMPOnUx7UKWBEwaAFweF2KZFQRZAyQCH5B7/YmPrjJaL3
	vV5YQ8FBsgWcwllKh2ek+Mc7QbFmrUwLm6sVGBDSSgllP9CNFNPLiifRrzqyN31o
	ZWdgTS8Yb2WRckcYLNG3NKTwhrNL6ZN+UWLdAg7Q6YZ8pw/79nQo/V6p/TWoveF3
	/OqbG6RPoL+zYe0HHl70wWsyKFySJpIVnqAIm4eUOl6UBJwit/bEScReLYK1she2
	UzKVpP8T4k2tG1QW+broDKURbvZ4UFpO3PUURARQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bsc9y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 15:14:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RBTx2t003836;
	Fri, 27 Feb 2026 15:14:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8kahmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 15:14:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RFDudb45810010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 15:13:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A10F20043;
	Fri, 27 Feb 2026 15:13:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C81920040;
	Fri, 27 Feb 2026 15:13:54 +0000 (GMT)
Received: from osiris (unknown [9.87.152.66])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Feb 2026 15:13:54 +0000 (GMT)
Date: Fri, 27 Feb 2026 16:13:52 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
        David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
        Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v17 0/3] Improve proc RSS accuracy
Message-ID: <20260227151352.10882Ca0-hca@linux.ibm.com>
References: <20260217161006.1105611-1-mathieu.desnoyers@efficios.com>
 <20260226120422.8101Cc2-hca@linux.ibm.com>
 <59b28cb4-4fff-4888-b562-7b7236e29d27@efficios.com>
 <e0af317a-d6ad-4de4-8bb1-215d5dce7351@efficios.com>
 <73e6fea9-caf2-4404-b511-11646013f8db@efficios.com>
 <20260227011201.GA1577380@ax162>
 <20260227131128.10882B8b-hca@linux.ibm.com>
 <b3447e37-89a0-4482-886b-dde87733fb86@efficios.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3447e37-89a0-4482-886b-dde87733fb86@efficios.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -3T30V_MJlKG4EfyyLoPMq8lNEDS26Os
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEzNSBTYWx0ZWRfX3nfVMoCIh2SS
 ucYO/H6Pgh/q+6vOm9ka1cfkWtOnJLyjSyOSLoRlMfW6wAvxXKJ1XacSWMeg/510bIvlfZa9/sw
 9K0RoTB+wmJi5cRqACCnPFxxO9yTArgS8raaLgsw4DHNm+k53nQ8f3OLphR3yUw8EDeayFr0g7c
 Fwmy/PE5p8I62l9msrWp7XHvbBWtbtXxsUDRgmCLwDgtyMc0BAHyAtHbx2j1mdXxlurDAZxxvC9
 OtWA/RfN0BOBPNFi1o/hK/RJu+Ersis0q1SDZA8LjpBWd5lq5TyXG4lPUhUOMOe2Op/M3YsbzNr
 RufkWhmWgk3XjF12baRIsxjLh+3roHIhlymjMEs5mvnxOKqVW5BEEFayiMLhEa3W+8YTttBf52t
 VH7W3+BBGslFFHs8GzH1NfusGc7LUkN6FXEuzp8JiPnC8dF/37wUo+K73EM/cNr331yzdcYF7rU
 W9r+TfR0TpCpcx0POnQ==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a1b4b9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=crcK52EdEUAz85siLdIA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: 7nyTaHxWFMAMGrOcBXMXoawwBqgiTdoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270135

On Fri, Feb 27, 2026 at 08:25:46AM -0500, Mathieu Desnoyers wrote:
> On 2026-02-27 08:11, Heiko Carstens wrote:
> > This seems to happen because the return value of get_rss_stat_items_size() is
> > larger than PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE:
> > 
> > PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE: 18688
> > get_rss_stat_items_size(): 21504

...

> Which fails to account for NR_MM_COUNTERS. Does the following fix your issue ?
> 
> #define MM_STRUCT_FLEXIBLE_ARRAY_INIT                                                                   \
> {                                                                                                       \
>         [0 ... (PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE * NR_MM_COUNTERS) + sizeof(cpumask_t) + MM_CID_STATIC_SIZE - 1] = 0  \
> }

Yes, this works.
