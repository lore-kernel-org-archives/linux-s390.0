Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23899C125;
	Mon, 19 Aug 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060646; cv=none; b=ovLlEKmbpkkr/zc6t71ErwXEkXkThVlThl75N7I5GPMaquMsDGzeM5YFIbZvUxvLkd2U7eKOyoi5Lkp+KcmUDFayEJ+cWPa4loFnv1XvvN1KVQVlTasuLiIG1Dh+DnSoakfE345BPd2NUhb5jiAi/nUO/A+20zLidjiT9YC7MTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060646; c=relaxed/simple;
	bh=nPglNlgsWQNJB3q9pg6OPB7F2KcVHB/diaOsaBJU5QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV4jiTsrSkua9RyASJ5oxJ0clwCKDpf91XF1kKIgEfFwWcKRYOsbvsNwzCIk7zJN2ykiTQU3QW/JxX06RctEiriWykEAUaiW7Ryo/qjG8hK4m9Qv7aeq3IAQDJbNm3abZRFoP7KxFH5lxUlo81lGu6yQCgO7r7WdyHu52o75Fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B7+vQSD0; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B7+vQSD0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724060634; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+ZWjCdrCN6NXpg1Gf3Jkt9J+nQF1VtPmf+2RIOyCxpI=;
	b=B7+vQSD0D3J6hzJlugKCZwgWS4U7EZJx69Ply160MvJ0ljdW9Y1CQIu4dtnwRca0IGAFhl9QyT9glbvisz7CuhVCb3l0RWKjcGAeW/183RPFeFlOUgc6g2tCxR3TlBoenEgo5T6iuFsk939Fk1J9ca7OATf8HuZd6Hfgf41L53A=
Received: from 30.221.129.140(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WDARsoM_1724060632)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 17:43:53 +0800
Message-ID: <bcf33c7c-c53c-4982-a2e8-32472259a88a@linux.alibaba.com>
Date: Mon, 19 Aug 2024 17:43:52 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] net/smc: introduce ringbufs usage
 statistics
To: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240814130827.73321-1-guwen@linux.alibaba.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240814130827.73321-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/14 21:08, Wen Gu wrote:
> Currently, we have histograms that show the sizes of ringbufs that ever
> used by SMC connections. However, they are always incremental and since
> SMC allows the reuse of ringbufs, we cannot know the actual amount of
> ringbufs being allocated or actively used.
> 
> So this patch set introduces statistics for the amount of ringbufs that
> actually allocated by link group and actively used by connections of a
> certain net namespace, so that we can react based on these memory usage
> information, e.g. active fallback to TCP.
> 
> With appropriate adaptations of smc-tools, we can obtain these ringbufs
> usage information:
> 
> $ smcr -d linkgroup
> LG-ID    : 00000500
> LG-Role  : SERV
> LG-Type  : ASYML
> VLAN     : 0
> PNET-ID  :
> Version  : 1
> Conns    : 0
> Sndbuf   : 12910592 B    <-
> RMB      : 12910592 B    <-
> 
> or
> 
> $ smcr -d stats
> [...]
> RX Stats
>    Data transmitted (Bytes)      869225943 (869.2M)
>    Total requests                 18494479
>    Buffer usage  (Bytes)          12910592 (12.31M)  <-
>    [...]
> 
> TX Stats
>    Data transmitted (Bytes)    12760884405 (12.76G)
>    Total requests                 36988338
>    Buffer usage  (Bytes)          12910592 (12.31M)  <-
>    [...]
> [...]
> 

FYI, The corresponding smc-tools modification has been submitted.

https://github.com/ibm-s390-linux/smc-tools/pull/11

Thanks!
