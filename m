Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B2233948
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395174; cv=none; b=pShvCWuWJOWwXrlVLU4Y5oOSHlNZkiSrlG9BcM5mD7n6lfTP+r7KmXVaHAQEUHtwT3vnqKbySDdgKXJmlKXJaz/8RPQxXaYrKRrUU1QA8Rj7TLai/JTpMH6Jzy9X3jcho096GcSThZIsR+Ep+cxjf1EtXXQy2ZJvBkZdGVrKG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395174; c=relaxed/simple;
	bh=MVO3liupPwj/Vlzs8En1OpPpt2fclexaglrXgfrHrFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5NS37Kr/gUlh5HAC5c6FwzO4lLChCHpdu6cYo3+pO1uas2r1aLfxitSNGhlx+bcEpLq+8ej+RLv1YdgKd/Wo9EqUSJs4kJYHd2Sle8REE87rHOMM16O43Vea0bx8pGRZukwvgTHsbW6g72y0gt/CFjKZPP5B41swrXswqmbjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r+ftn+GW; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r+ftn+GW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783395169; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=UL4ybNwsHd88nyr81UjZx7Ri3ifdNe2oAPkU7R2Fbg8=;
	b=r+ftn+GWsJNtLEl25KIhm0hyr+PvDVncFMfBLZCnc5H0KYrFe7YtlLsitfx35rW2Rmok6PX1z0oR3T0khK2zjRTpKhb503IFBvO0vpBzj9eAvubCPL3czbWoct8lUrdEaeh7V9kJG9JLwcBLx7KdwHD7k6Pf72RYSdPA/cieq6A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6bLLSS_1783395167;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X6bLLSS_1783395167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 11:32:48 +0800
Date: Tue, 7 Jul 2026 11:32:47 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: ignore peer-supplied rmbe_idx and dmbe_idx
Message-ID: <akxzX5lh6fRQZmaF@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260702171137.1099051-2-dust.li@linux.alibaba.com>
 <20260703171239.625D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703171239.625D21F000E9@smtp.kernel.org>

On 2026-07-03 17:12:38, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
>New issues:
>- [High] Hardcoding `peer_rmbe_idx` and `tx_off` violates the SMC protocol and breaks interoperability by ignoring the peer-supplied buffer index.
>
>Pre-existing issues:
>- [Critical] Missing bounds check in `dibs_lo_move_data` allows an arbitrary out-of-bounds write in the kernel.
>--
>
>commit 60af5c80d503d1904779918ca5eeba8800e8bbe9
>Author: Dust Li <dust.li@linux.alibaba.com>
>
>net/smc: ignore peer-supplied rmbe_idx and dmbe_idx
>
>This commit modifies the smc connection setup to ignore the peer-supplied
>rmbe and dmbe indices from the clc accept/confirm messages. It hardcodes
>the peer_rmbe_idx to 1 for smc-r and 0 for smc-d, and unconditionally sets
>tx_off to 0, assuming the peer allocates exactly one buffer.
>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -729,11 +729,15 @@ static void smcr_conn_save_peer_info(struct smc_sock *smc,
>>  {
>>  	int bufsize = smc_uncompress_bufsize(clc->r0.rmbe_size);
>>  
>> -	smc->conn.peer_rmbe_idx = clc->r0.rmbe_idx;
>> +	/* Linux uses exactly one RMBE per RMB (always index 1); ignore the
>> +	 * peer-supplied rmbe_idx to prevent a malicious peer from setting an
>> +	 * out-of-bounds tx_off.
>> +	 */
>> +	smc->conn.peer_rmbe_idx = 1;
>>  	smc->conn.local_tx_ctrl.token = ntohl(clc->r0.rmbe_alert_token);
>>  	smc->conn.peer_rmbe_size = bufsize;
>>  	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
>> -	smc->conn.tx_off = bufsize * (smc->conn.peer_rmbe_idx - 1);
>> +	smc->conn.tx_off = 0;
>
>[Severity: High]
>Does hardcoding the peer_rmbe_idx and tx_off violate the smc protocol and
>break interoperability with standard-compliant peers?

Thanks for the reporting !

You are right, althrough we only support 1 RMBE/DMBE per RMB/DMB, but this
breaks SMC protocol.

>
>If a remote peer multiplexes multiple connections into a single registered
>memory buffer and assigns an index greater than 1, ignoring this index could
>cause the Linux client to write its rdma payloads to the wrong remote offset.
>
>Could this corrupt the memory of other connections on the remote peer?
>
>>  }
>>  
>>  static void smcd_conn_save_peer_info(struct smc_sock *smc,
>> @@ -741,12 +745,16 @@ static void smcd_conn_save_peer_info(struct smc_sock *smc,
>>  {
>>  	int bufsize = smc_uncompress_bufsize(clc->d0.dmbe_size);
>>  
>> -	smc->conn.peer_rmbe_idx = clc->d0.dmbe_idx;
>> +	/* Linux uses exactly one DMBE per DMB (always index 0); ignore the
>> +	 * peer-supplied dmbe_idx to prevent a malicious peer from deriving an
>> +	 * out-of-bounds tx_off that causes an OOB write.
>> +	 */
>> +	smc->conn.peer_rmbe_idx = 0;
>>  	smc->conn.peer_token = ntohll(clc->d0.token);
>>  	/* msg header takes up space in the buffer */
>>  	smc->conn.peer_rmbe_size = bufsize - sizeof(struct smcd_cdc_msg);
>>  	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
>> -	smc->conn.tx_off = bufsize * smc->conn.peer_rmbe_idx;
>> +	smc->conn.tx_off = 0;
>
>[Severity: High]
>Similarly for smc-d, does discarding the peer-supplied dmbe_idx cause ism
>writes to target the wrong remote offset if the remote peer uses an index
>other than 0?
>
>[Severity: Critical]
>This isn't a bug introduced by this patch, but there appears to be a missing
>bounds check in the smc loopback driver:
>
>drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
>    ...
>    memcpy((char *)rmb_node->cpu_addr + offset, data, size);
>    ...
>}
>
>If a malicious local process acting as an smc loopback peer allocates a
>small dmb buffer but sends a forged clc accept message over the tcp socket
>with a deceptively large dmbe_size, could this trigger an out-of-bounds
>write?
>
>The local smc client would compute a massive peer_rmbe_size and pass a large
>size and offset to smcd->ops->move_data() when transmitting data. Without
>verifying that the requested offset + size fits within the actually
>allocated rmb_node->len, it seems this might overwrite kernel memory.


This is the root cause, I will just send a patch fixing this.

Best regards,
Dust

>
>>  }
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260702171137.1099051-2-dust.li@linux.alibaba.com?part=1
