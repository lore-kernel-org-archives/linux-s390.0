Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607418A6A4;
	Tue, 30 Jul 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365929; cv=none; b=i3LK7Qv6ajo2pVVJD8vAXKEFkpezDwT4lLhR59JemwnJKBhH6Dg5Ha1ReMGFDZQOWqSr69MEBRLADwfRDXBpLBwOgVu9Qa3uTEclqREbdd08aFaNTumZTzQkj1E7iJ+kVJor7ovi4D0++856eFCyL3VfXOAyq41RKEFBFXM8DIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365929; c=relaxed/simple;
	bh=XufagOdkJkps80xAo9ok+w0eKHj7WecCO6ggMzw+xps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWvG5uv9Sloqx8w/LZ5IYXZyoVDOACoHZM+C6/vbahumGa3/RqtOiORkK1IhoaQM5HEM8vE0R/uiT0PobtX97cTkyD6gg8QzInNbr3fI6m1CVjQwBolhrnFb1PtjK9bTlJX+cpxWs1LleMcef1/zIM3fh2PBOx7py/nB6UR1fWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Het8zj2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Het8zj2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E682C32782;
	Tue, 30 Jul 2024 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365929;
	bh=XufagOdkJkps80xAo9ok+w0eKHj7WecCO6ggMzw+xps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Het8zj2yrCyj96uTEK9RcOkE0tFZ2n2TbRVL6pYwONQoy/5grj9WVBuQRZkjucD78
	 gh11dw2PI9FTNmuigPaVUuQHUZYmdC07OAbGQd1XIKGLY2Ai0Y4mk/isie+orxaq/1
	 Sllym+8nIm4EQXrXtWpeIHPzdyjr8joydK0EWLkoV8ROUg181vdL3+NOQUrp8/DwZw
	 qrHD7+tDykDFZoHzFChYBkPa/0yhcPj2STFShB3MBBxjcwBjEDhZHL7+AGpxeUf8+d
	 okxQyFRPKLIDHT/t7v4zXQYAp47dc85R7wXsANyUib0HHZx/rPQsZ1Cm3MIgFJa1d+
	 XdCDA0Q4K4cQQ==
Date: Tue, 30 Jul 2024 19:58:44 +0100
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 3/4] net/smc: remove redundant code in
 smc_connect_check_aclc
Message-ID: <20240730185844.GI1967603@kernel.org>
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-4-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730012506.3317978-4-shaozhengchao@huawei.com>

On Tue, Jul 30, 2024 at 09:25:05AM +0800, Zhengchao Shao wrote:
> When the SMC client perform CLC handshake, it will check whether
> the clc header type is correct in receiving SMC_CLC_ACCEPT packet.
> The specific invoking path is as follows:
> __smc_connect
>   smc_connect_clc
>     smc_clc_wait_msg
>       smc_clc_msg_hdr_valid
>         smc_clc_msg_acc_conf_valid
> Therefore, the smc_connect_check_aclc interface invoked by
> __smc_connect does not need to check type again.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Thanks, I agree that in the case of a SMC_CLC_ACCEPT packet,
which is the case here, this check is unnecessary as it
has already been performed by smc_clc_msg_acc_conf_valid().

Reviewed-by: Simon Horman <horms@kernel.org>
