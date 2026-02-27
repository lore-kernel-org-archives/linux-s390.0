Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E222CBD9;
	Fri, 27 Feb 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198241; cv=none; b=lGzpGhjQZcneOICQFE8g8HEr3glu5UpRzp6hx+MEVvcmwOzrfuOQaqcvx1r5oJjZUL87amrhJsTe/Uish00z/Kdejm+CL52IXEqkUPOPiBZXb+ntcXsxQlRzfu0th/iA9WDkp8xqRmeaZBf+N5mY0RWC2te8VMroQvv5tWxaXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198241; c=relaxed/simple;
	bh=KdMe5UBcpVfnzxnFBjcFRrLpsIKDlzxCU4D7K4nxX9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9avnEYx4wvy9ns9j315T9y8HYnrLrm0bJLykxProrhbSNpoBMln1UjOVGrMhSnPCOhjRriT3jN1RUalbOxO5ehnmWz+reanZ1ZsV54cDR709XBalPPFbusEfz1NNHxngi/rdAYyB0IKAqOmWTzwIgtKUt6T/iroDY67YaCuT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BTJR2vm0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BTJR2vm0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9viZC2757367;
	Fri, 27 Feb 2026 13:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6WjlJpHQKzBlWKVpwqyUEHBeZgBzSx
	Y5388W5FkL58k=; b=BTJR2vm0fDzeENYLqFYQ2dDe9icMrOXI9wTnvA2kiCnRXT
	gH1/CO/zfo9nMNHYB//RjWvssL7Jz3YhxGCku3qzLac2LDUj+0dZfWUUqhhdJmNg
	CPy2NxjTo1PaiA9DGaX+nGmfBW+JE7YTq0LUKBKIkNuBgL7s8XZQX723E/+JUjM1
	WPGJGeayO4+Vg6u421YBaKJdFhjDfFUZdz9yRVNimgY+KXBROLbUzWiXYB6+DUJG
	br1pKLQCMoWE/yOg38mNMsGzlQFbBUZ2JqRh/H/TJTEUqHcC95Fq8kug6evVHJVf
	RoKAFgmg2zFe+LSbyCw3GXu81pVbzuwIaLvGK1kg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gv1u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 13:11:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RAXfZm013419;
	Fri, 27 Feb 2026 13:11:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdyjdvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 13:11:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RDBWJM31785484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 13:11:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB4192004E;
	Fri, 27 Feb 2026 13:11:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05DDA20040;
	Fri, 27 Feb 2026 13:11:30 +0000 (GMT)
Received: from osiris (unknown [9.87.152.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Feb 2026 13:11:29 +0000 (GMT)
Date: Fri, 27 Feb 2026 14:11:28 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <20260227131128.10882B8b-hca@linux.ibm.com>
References: <20260217161006.1105611-1-mathieu.desnoyers@efficios.com>
 <20260226120422.8101Cc2-hca@linux.ibm.com>
 <59b28cb4-4fff-4888-b562-7b7236e29d27@efficios.com>
 <e0af317a-d6ad-4de4-8bb1-215d5dce7351@efficios.com>
 <73e6fea9-caf2-4404-b511-11646013f8db@efficios.com>
 <20260227011201.GA1577380@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227011201.GA1577380@ax162>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a19809 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=WbwKx_aOVzRSyFeedoMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: engyVFzmJTSGnUMACbHisbjpzir_4QkW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDExNiBTYWx0ZWRfX9eYZTNcw6g2P
 XnyXHaBQR2w4S6iIaEjeDrN3Tl4S5BS+b1ccOVoqOrlenCRnbcJI+UGA52lDiHrjUnH5IgtJvno
 d0GTfXcVAxMB/eamnwOZGZFB7lbsEi3zYsqCwtCIYQ+ZDgMsrX/4I4pAouHpsCK5YmueKAuLNcH
 Aiz5gXF6j5bgA7nUYcWI8UnfAa4vScjmTd5e4HOaO/GL0LociGszGw9NtkE0lk68neAlORVgXKf
 BpFR7pTI+cPo5bZgVIWD1cQ80vJbpxWQF1jQKVRiBKz6UbY/VqCRzMqgnCaYHKdqEylsBwIVZxO
 VUAKK+iSCqiklIaXW/E/vASlTdW8tIVGp8Sm+hg1oVqhqBrzzbMBalfblTXv3OUbfikLM2OxZYX
 IBVMMGaHAImkE/4DMwKPhkA/cITJnZKPWrx7DBFizU7qdDkdyMAST2awCKBLDs7GqhBDL9p2bE6
 LQ+dt6dcbyObu2cSLkQ==
X-Proofpoint-ORIG-GUID: jr70vzbDxhadr_F2vwxMHo9jZkWB_9Ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270116

On Thu, Feb 26, 2026 at 06:12:01PM -0700, Nathan Chancellor wrote:
> Hi Mathieu,
> 
> On Thu, Feb 26, 2026 at 02:38:04PM -0500, Mathieu Desnoyers wrote:
> > I've successfully booted a defconfig s390x next-20260226 kernel in qemu
> > with 1 and 4 CPUs, and within a nested s390x VM on 2 cpus.
> > 
> > I guess I'll really need more info about your specific .config and
> > command line args to help further.

On s390 cpumask_set_cpu(0, mm_cpumask(&init_mm)); in arch_mm_preinit() writes
out-of-bounds into swap_attrs[] overwriting the terminating NULL.

This seems to happen because the return value of get_rss_stat_items_size() is
larger than PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE:

PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE: 18688
get_rss_stat_items_size(): 21504

Here I stopped looking further into this. I guess you will figure out
immediately what's wrong :)
