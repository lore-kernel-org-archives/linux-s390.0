Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78A1C6AD;
	Wed, 20 Mar 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914429; cv=none; b=bHopm7MGWAxo5gepYFj+9LITeRYBvUpezfepGVkEz/BpQ4BocoJskE1Bud1PKbFKv54HPypNti4VutQ9F62IU4VFRbI+hVKpYT++ZyED+GSQzsY65FFU87mjUdOtg/fj5d7w7qEEjp8Dw4917E3a+Q+fvCaY0cYOhojukxwgXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914429; c=relaxed/simple;
	bh=ymUy5F0YzcS6a59CGMwBD/LvafHPbiwNmiswNU3m8d0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZeqPD6L+4eRdzISIr/L7GBvcGLMivgH5qsB+voa7JGq1IPAW5UlKrWzRvBimZ+E5K8uoh6Hp29wX3fSXKLTAaw4CGhtpTiChqQvP+Y18Ncy/7LAwqtPKUzzA8zX1Ej/3xxSqKOdKSu+U2EGw+Y7OIW5QkEyf3fZZrSe7mz7HIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaE/1QxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaE/1QxN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CE36C43390;
	Wed, 20 Mar 2024 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710914429;
	bh=ymUy5F0YzcS6a59CGMwBD/LvafHPbiwNmiswNU3m8d0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GaE/1QxNHJr+guythnnODDUtiQ9Mc6v0MuQONVTV5R31Y00kjCbSbpxgXIzfs7zEv
	 MPmAjnhM6GEfNjlGIFc9rj+aeacAlBUZmblWP8q6lchCaQIBOPExjJQ/cjiNI51zMJ
	 wf0yU/NbMRwvHTe3U9cBiN4nkUemNaGtmZhecPIMAvmTOFazDTVaUVboX7GsoKPER9
	 ojIciAxouQpMLIKJ9qGChz3wcNHgDLbBsJmWCB/2alDH8iVOzqEKi0hheofWlnPVlN
	 0vR5TziuAFQCD1womvg7zoGF4TVK5keVU7UIFDuIuTCXZs1er1vRAV84PTWGBm4JwD
	 hwhMluerxNwfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 040DBD98302;
	Wed, 20 Mar 2024 06:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] s390/bpf: Fix bpf_plt pointer arithmetic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171091442901.8613.10642779913572701774.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 06:00:29 +0000
References: <20240320015515.11883-1-iii@linux.ibm.com>
In-Reply-To: <20240320015515.11883-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 bpf@vger.kernel.org, linux-s390@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 20 Mar 2024 02:54:12 +0100 you wrote:
> Kui-Feng Lee reported a crash on s390x triggered by the
> dummy_st_ops/dummy_init_ptr_arg test [1]:
> 
>   [<0000000000000002>] 0x2
>   [<00000000009d5cde>] bpf_struct_ops_test_run+0x156/0x250
>   [<000000000033145a>] __sys_bpf+0xa1a/0xd00
>   [<00000000003319dc>] __s390x_sys_bpf+0x44/0x50
>   [<0000000000c4382c>] __do_syscall+0x244/0x300
>   [<0000000000c59a40>] system_call+0x70/0x98
> 
> [...]

Here is the summary with links:
  - [bpf] s390/bpf: Fix bpf_plt pointer arithmetic
    https://git.kernel.org/bpf/bpf/c/7ded842b356d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


