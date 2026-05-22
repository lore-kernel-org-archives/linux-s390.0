Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094A3F4113;
	Fri, 22 May 2026 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457031; cv=none; b=u6dP8zDt8GZKFR2zHZEE5Tk/ofnK6LyCroyW3xJDbd2OE2+Xa32IwhDJz09zbRwpuUZaqCKif++TsP7IC2FGkjKatlCdcTOvaw4y42WrQApsv+sPncDbMChcCy59RA6UFt+izAQuJgpuyzUV4WaurdVxl5x5MP47cWCFw0Q/LcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457031; c=relaxed/simple;
	bh=8W+LGMUsWA131vxdXWC85Y5qagImInjQ1Y1ZTvT87jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eh4loVR9NuKiLn6CaCYLY8hAeYN2D4bimKwV7l7luf7+Ob/CSEe6zboaKjbap6ImihPnRRyiI6/yY4XBvBou1AIKHdCbAwWnHOaFhQHqe9ziP/uLv+5bvB3x1ZDvSFuadRUBd52eqtwzJDOvRVUOGxi8xw8w96OiN7P16TlCj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SMIHcPkS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SMIHcPkS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7SUv8789447;
	Fri, 22 May 2026 13:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b1GMoi
	L1yrpBf3BGw6zwVthrJjiACmQlrFFwbP63Fn8=; b=SMIHcPkSSIz8qmsF18v208
	/sqLLiiEArni/FXr9B2QkMjiGDZiFX+MdG/qoXlQBVkFMpEBsu14+hHITO8X8i8E
	+ONYeT5jGovmt0ou+Ifdz2eKlKeGQcqW9L5IivMShrQXHXNWSHKB2tmhjHDuNAwa
	1XuRIJq2Z3WE8I+lA2EnQes3u8AArgzfbiyrltG6ZnpqlNc1KAf7OKlyTvLAHJnb
	r+yeBrRm42tn+auDT6qUiJ7YRZHDR6cQ4DXkxZsrIy/LjL65AJyhtzzno2pNO9Lv
	K68FVChXpKi+cpRaSiA84kv9K7bM6MDw/rfLCRWHpp3i6QE7KSJHWeF4wt1yqPZA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8tmmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 13:36:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MDO4vM008210;
	Fri, 22 May 2026 13:36:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w96cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 13:36:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MDapNd52625712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 13:36:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E994220043;
	Fri, 22 May 2026 13:36:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 860D420040;
	Fri, 22 May 2026 13:36:50 +0000 (GMT)
Received: from [9.111.175.40] (unknown [9.111.175.40])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 13:36:50 +0000 (GMT)
Message-ID: <edd509f9-c64a-4802-bb5e-df06f638457e@linux.ibm.com>
Date: Fri, 22 May 2026 15:36:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: fix locking in .getsockopt
To: Breno Leitao <leitao@debian.org>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ursula Braun <ursula.braun@de.ibm.com>,
        Frank Blaschka <frank.blaschka@de.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Stanislav Fomichev <sdf.kernel@gmail.com>
References: <20260521-af_iucv_fix2-v1-1-f16b1c510aa9@debian.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260521-af_iucv_fix2-v1-1-f16b1c510aa9@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfXwdjc7oIoHt07
 yZuuE7IPCuaYXs424DnLb7Lk2PBLwRUfbiL53/8Ck8axqHWaoFGsmXES+5JsQGbkcUtdHlPvwjU
 N5188G1ZrBseyzDV6oFLgNFTvTcptD6mauWOf4xJ4+E9aVXVdvkxSN8fQbDXwh1vzgnWvfFUxgC
 5Y4dtHX79LephMP/zAmTkt4t48Akn8mQggaI4tYxXK/pKHVatfn7AkC6Q8fwB6WcdAGns8BMzwW
 wQR16SfPuIBJVfqLRUg6IQF3g13q/oEs0+3YkDXA58TrfsJkMCgAtZahkQ/MuVS0CWi3FnSVEac
 jjub8D95SuMBXJg/y8L9+0sgj3utvqr79ZKIYP4IGfDuNRvQzzczAopkwBVyVN+37aKe6RTMf7K
 bnZTMgzVwbg+57SddIJecWWA5IxC/ySvyQSrZp9376NqFX5pFVwPgQYxKo2y4Gasdnx+AUBbdg0
 OEMc556q6C5eIs26c5A==
X-Proofpoint-GUID: WoJam2dSynZ3Db6YhFov_f44YprzAx86
X-Proofpoint-ORIG-GUID: fIXVeU-yqX4WWdqaqP9MloM6Hz_F2HYe
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a105bf9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=xNf9USuDAAAA:8 a=VnNF1IyMAAAA:8 a=IQu2pwtsZk2u-v9NKpYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220136



On 21.05.26 16:11, Breno Leitao wrote:
> Mirror iucv_sock_setsockopt() and wrap the whole switch in
> lock_sock()/release_sock(). The pre-existing SO_MSGLIMIT-only lock
> becomes redundant and is removed.
> 
> Any AF_IUCV HIPER user can potentially crash the kernel by racing
> recvmsg() with getsockopt(SO_MSGSIZE): the SO_MSGSIZE arm dereferences
> iucv->hs_dev->mtu after iucv_sock_close() (called from the racing
> recvmsg()) has set hs_dev to NULL, producing a NULL pointer dereference
> oops.
> 
> Suggested-by: Stanislav Fomichev <sdf.kernel@gmail.com>
> Fixes: 51363b8751a6 ("af_iucv: allow retrieval of maximum message size")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Note1: Not using goto/label to simplify the merge conflict that might
> happen with the migration of af_iucv to getsockopt_iter
> 
> Note2: This was only compile-tested.
> ---

Thank you very much Breno.

I ran some regression tests which call IUCV getsockopt(SO_MSGSIZE) while
sending and receiving data via IUCV. I have not created a specific
reproducer testcase of the described race, which would require enforcing
a problem in IUCV over HS congestion management which triggers an error
path in recvmsg().

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Tested-by: Alexandra Winter <wintera@linux.ibm.com>

