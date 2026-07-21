Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FD3EF0BE;
	Tue, 21 Jul 2026 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633866; cv=none; b=d3B0FMjO0w7IAO/LyjWbMej5F0ikZ6rGGeCKXNClbVrmIaOa6fZtlIVnf091sEUhoOBjKpkIIdUDU6DNz1fx3w2sEBX0L0APo6xZTjz5qfssG6hqnF8cjmQhvjbGamTjUtVfcF5LCofjgWOTkj6Y9zxhei+HN7V+slDzq5LOVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633866; c=relaxed/simple;
	bh=/tyVtJc0klLFcW61s8rugMX5EeAZGUSjMCRnsvx+GbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IboV3aQV/yK1Vz5b/SNaxYW60/Zt0JPsISBPPKEBouWcLLabEA7QWub55ocrIzcl0ruH4/bg9rpxgEr/Jc5OYZC7FRFhWfr0/m4GBJcFBkacd5fIov2v0AIKhMifJ1eOJU5xbEaSIgnDVhtCKwdDKH8KhkU33w+wDHnmSradwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k1WOeL4i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k1WOeL4i"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LAfgZK793208;
	Tue, 21 Jul 2026 11:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aNRlgP
	bK3zEmFdjyBI2O2RlvvV8/JFQWq8qGVZEFiag=; b=k1WOeL4ilg7HlF1rgbc/nh
	zonZLNRjA+9w3gXhK6b0EhdoG3xVpjtnhFzv7mMUhP8B3qFILeJCo2kk04A9FrHV
	Sjevczbj/aNPUh6hiw8D9YKmIcPhH1BJW4JgDrLTUQ+cJL4yedr6f53RRfu00Q/4
	52zD7zD8mmQPA2d8kyR4JW+MG3/G/nlL/a/ZmpYtrfJRZQnuK954wy4VvuaL9Cis
	8JxYDf8MAoGAts9MwlkqqzQC0lIstLgIL6CVclWgRcO7JsImssWXRLu2FhiuE1WT
	kbeAx7uHc+fq8qWMtmsQscWCkessl4XvMhzWewd47h5HEaA/0FeP0DET+4EiJjCA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790v94r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 11:37:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LBYmjH024568;
	Tue, 21 Jul 2026 11:37:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g9uy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 11:37:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LBbTOH25100716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 11:37:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 216BA2004E;
	Tue, 21 Jul 2026 11:37:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E515920040;
	Tue, 21 Jul 2026 11:37:28 +0000 (GMT)
Received: from [9.224.94.95] (unknown [9.224.94.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 11:37:28 +0000 (GMT)
Message-ID: <3da353b3-a159-46ea-83fb-807a2a242e49@linux.ibm.com>
Date: Tue, 21 Jul 2026 13:37:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: fix use-after-free of a severed iucv_path
To: patchwork-bot+netdevbpf@kernel.org,
        Bryam Vargas <hexlabsecurity@proton.me>
Cc: pabeni@redhat.com, twinkler@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, linux-s390@vger.kernel.org,
        hidayath@linux.ibm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, horms@kernel.org, nagamani@linux.ibm.com
References: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me>
 <178461900540.131537.16161978052316384549.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <178461900540.131537.16161978052316384549.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3fBmCmFhyZqJIxct3h388N4trjsbq3hy
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5f59fe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=-x-WvX9gwJZ7GEVxNYoA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExOCBTYWx0ZWRfXw9vSMjf6Z8Pn
 7B7uemPnnwMB/zb1QLorl2Cjyg8s/gn3nF0hTlp2XGe5tqHOCGXmsk65k5HFqReVAtvoXtcWJWu
 FfX9Uw6cSImwSTvLNUxYIMyqvRiRMyQ=
X-Proofpoint-GUID: 65X9kMEfWxpvaJ17y6RDsQYhpVIRihwc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExOCBTYWx0ZWRfX2f5R77v8QlZe
 G2irt/85bK9OgYcEXgAEgAAfyvoWz7Ol8VMJwXrwXVe7QLhxP0jNQxJ6oPwc9JPqRUYLPeVNTNU
 xng7FAnlRNjJbvBktUnUCzqZ/Xv9LLJ0sYN7yUNkTHVVarRvdrF3/trJZJSvfvrXxTNwCOtdkeT
 7AhJlIdADbAYzJrvRO2mEWMv0h/DrFREVxYaNg/yLHvj9skyl5bhzZZK9TUQlZIeb98ArlwNuyZ
 6HkXrVZTjL/0fxAyr1bFbqlEcDZJeX01cgYdGeOWkrNCHySE7iaQn1ni3jqFlp/r9uLY49r1eh3
 L17tydVKEsOTKaT1s0cLNMjR0bbnSy9/v8zZf15ySElqTmjAJnkJ+OCSFkTXnVkmc9FA1zrwLbH
 MmdI2LE3LSu0TR0Cmt4jlg5lFSlL9awqCl0wCjWEwD+6G6IN7H/T6YIn4k16KNN3mFldcIDmksH
 DPI4pg5RD4ZCVLsAtcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210118



On 21.07.26 09:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
> 
-- Original Patch for reference:  --
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> af_iucv queues not-yet-received message notifications on iucv->message_q,
> each holding a raw pointer to the connection's iucv_path.  When the peer
> severs the connection, iucv_sever_path() frees that path with
> iucv_path_free() but leaves the notifications queued.  A later recvmsg()
> drains message_q via iucv_process_message_q() and hands the stale path to
> message_receive() -- a use-after-free of the freed iucv_path.
>
> Drop the queued notifications when the path is severed; once the path is
> gone they can no longer be received.  This also frees the notifications
> leaked when a socket is closed with messages still queued.
>
> Fixes: f0703c80e515 ("[AF_IUCV]: postpone receival of iucv-packets")
> Closes: https://sashiko.dev/#/patchset/20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me?part=1
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  net/iucv/af_iucv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd..2869a103f7fa 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -337,6 +337,7 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
>  	unsigned char user_data[16];
>  	struct iucv_sock *iucv = iucv_sk(sk);
>  	struct iucv_path *path = iucv->path;
> +	struct sock_msg_q *p, *n;
>
>  	/* Whoever resets the path pointer, must sever and free it. */
>  	if (xchg(&iucv->path, NULL)) {
> @@ -348,6 +349,19 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
>  		} else
>  			pr_iucv->path_sever(path, NULL);
>  		iucv_path_free(path);
> +
> +		/*
> +		 * Message notifications queued on message_q still reference
> +		 * the now freed path; drop them, otherwise a later recvmsg()
> +		 * would pass the freed iucv_path to message_receive() via
> +		 * iucv_process_message_q().
> +		 */
> +		spin_lock_bh(&iucv->message_q.lock);
> +		list_for_each_entry_safe(p, n, &iucv->message_q.list, list) {
> +			list_del(&p->list);
> +			kfree(p);
> +		}
> +		spin_unlock_bh(&iucv->message_q.lock);
>  	}
>  }
>
>
--- end of patch --

> 
> Here is the summary with links:
>   - [net] net/iucv: fix use-after-free of a severed iucv_path
>     https://git.kernel.org/netdev/net/c/be7cc4656eb1
> 
> You are awesome, thank you!


Ah, Paolo was faster than me.

@Bryam and for the records,
this should not be a use-after-free. After iucv_server_path it should not be possible to call
iucv_process_message_q() anymore. I agree that it is a message leak, the pending messages indicators
in iucv->message_q are not freed anywhere. I would have preferred to do that in iucv_sock_close()
instead of iucv_sever_path() for symmetry with iucv_sock_alloc(), but this should work as well.

Having said that, as we discussed in [1] the socket locking in af_iucv wrt receive path has
deficiencies, and we will follow up anyhow.

[1] https://lore.kernel.org/all/20260711041119.12764-1-hexlabsecurity@proton.me/



