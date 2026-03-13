Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D503AD521
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415407; cv=pass; b=PjB2Ubsp+KTnNe7QCTSUkc2yjY2gIY9OqpiLZrsZUN0cbX82AYcZj25gtOOUlgZ7HBoj5uacfWP9DabGJAYfk4lOVcT49Dhjme6AKcsQAdW7qxmqTVVlGbp0g5UpaFDhfK2COW/gU/VpYyFfIKaxzAP7gfMGjBlDptpOC3E58co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415407; c=relaxed/simple;
	bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0Wep8NmdSt/h0EUSlqZwhhBMl/VrTA1ytjBOF6zN4LL3UmlbC8ka4Xw7CxJHU0S2ukdtm4S+QDVaif0FZWwHi3/bgXNNvmS18TNjJUv7Ygp8DFgDQ0HE4ilb/2xpQnOx3vLpUWucqlSYTUq2SRmedet0LcBw+LYgAIMuyYmbI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqLfArxx; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqLfArxx"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79885f4a8ffso21027847b3.3
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 08:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415404; cv=none;
        d=google.com; s=arc-20240605;
        b=NMBR+gdalosHo44Yr7jF2NxwLMN/LRnamwidiIrTvjc/lzZmK6IVFbuUimCUlIU75c
         ++uqnh8QeID7VAyuNbZ6l1uW2nVWgtlTAR01GCUdljVbQzF8xNfTMy4aoPL+ciC2noQX
         x1AQGs18U6Ra58EoztXPp3Ej6GV1Zq3TfFnenx/TAMNRSl2iGdyMEzGS6cXfPSBMBmJQ
         yAZ37A7BKfvD26uBgQRWaGgbXXqQ8G23GGM2/3bY7aRXNYjd7T+gMNtQlfGBTwZ7onZb
         22t7S1hsJiZqr2tFzs1B2MRS6dspMqm+8BOm00ZJv71NPohuFaPIZ/JdlNg9CODQ8u81
         UDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        fh=KC5tm165VHn3QlA0jZNNWKYjddnJ/Q2w4shFEnjA82Q=;
        b=ImvZjLO2rdUycbKUCeTl/0J7zPg2Gzln1lZO39hRgfasJOv9bDhDSUq6ZfzgG5V9v4
         grpU38rM38Gub//jxkJnMLwVEvscLU6fryExPIeDR6rcilD7Xd0v4cMa9bnBU1AnBFxW
         PiFxBKHZr6z9LCCkx99j5MH7WGCeCphzvdK0gT5YiVc3c93aNctWwB31MR+e8Ch3NhTH
         y4uVQxTkBjhDw0E5UxmO5S0qg3j4Uub4UcogwY9sa/Tpx/mE3r8PXiOjeSUnOP8zmqBt
         4DYhLnKzJ8A+z2xRxNzDSggQM5WfXxCAcSzqk4FUn+H/zhPA4jtLzAnX/Hx/KPSnY6pM
         niDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773415404; x=1774020204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        b=MqLfArxx9WavGOVcNbQ/YuikDXr8zrfI9pMe0VvodHyONDK2YYVYs7IpP9apEBlypP
         Ez6x5SRvTBvRGER2SNjESUQ2YXaxRkjQa69ErILkq9lg4oHuwOyIL+mUnetUkw9uOzYD
         MiNQGv/iuGVu5xzhi9l0MzUJFHUjEXVss35CJIubve1CgfqOR7/bJatkpPifQV8jtq39
         z5LPpzeg3WjOQQOtcpHzolhS44W/kpZ/pYSIe9J5CSvPfJpcfM1Z4hKi9rJHYuuATXZs
         br8HVDqKkQ8FPlUFhN9asfKCUmWAvofbONWOra37GZQizZfJj70IkNZk13GKLj/AGvGp
         dRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773415404; x=1774020204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        b=g8oIbKsJxDmI0YeoPGflNccGsNPVAdjTqABMVMuiB5ui36spSTPdbZXSieAsw/GlbD
         fyZw/7tPi4pnmbuoEqNQcFziMCIt2BHdRqRHYwcesMZ9PqPGQem2aqXWWJdV2Yepq40W
         ab/2WrSfjupvn6sb336BrJpQD1Qba+xGcY6Wqan3cbuuAS9u8tpfFIm6AK/APsuI6At0
         OR0DlQnVH1t8A1XIpz5gwszy3AayNgQ75TNfZpSa9XxAqd6c/hCvgtOHZAT+She0Gs6T
         Jnu21L5FOx67JHrHUvROlD2NyRD/o0LddNGfb18kZeQqrl1/1SNQ6AcKYee5ZqYdSIrr
         pYww==
X-Forwarded-Encrypted: i=1; AJvYcCV78yWoitbiVCp9mEw09cieDnvZe/gZX08TxbfXS6EEkh2uMbaVmFs8h1lpm3WSL4s9pQGReidpzWAh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9XubbRNOZUpNb2fUKeXpVYdjaohqx0b/e/i1p1E4NvdTuJmZ
	8MO6FNbk9os7Fzw81JyaQb7DFaF+FbBSkYZx8cKCC22tNyKnDjHD/FcLNoDrcfM/jM95avi269p
	+PsjKMxO4VWXb10dtRFIPCON6tFVsoAeE0EALsoPI
X-Gm-Gg: ATEYQzzAUZjeZDK/7uk6BN6dAx+HWEOauFelcybXo2LbL7xrWpo6tgLBGVOfiu//M/8
	vkpGa+fsUzB3WcWoyjt3C9sIyAfkQT7vdzAznIiH7GV4v0T+iroix9O0nST+EYezW4U6TqEHuQo
	wPgr1mH7A36v9PNSvzs09M8+lnPcXxN0bAh5wX+ur0X/2hEqAuAyKjjQ+cFex3lPAhwlmilCQZP
	qpWPiH4DCfAaVVBEUJUj5IKypVcQGdd74ToaUXhyhPS8F4Anq4t+o/SmxMtK9LDaClab4GkhHIc
	60EgTPQ3
X-Received: by 2002:a05:690c:d8d:b0:798:240:dc with SMTP id
 00721157ae682-79a1c1ff74fmr39519447b3.44.1773415403629; Fri, 13 Mar 2026
 08:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313151609.83026-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20260313151609.83026-1-bsdhenrymartin@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Mar 2026 16:23:08 +0100
X-Gm-Features: AaiRm52KxJMaf1ydBJZ_jjLOyjV7GYRKOtKNeJuwOG2OEoR0W86DQ9uF5UWnY0Q
Message-ID: <CANn89iJSyAb+hrNEoGrum_W0Tfd_QY82dW4Y+YrvVqkPzdK=qA@mail.gmail.com>
Subject: Re: [PATCH] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
To: bsdhenrymartin@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 4:16=E2=80=AFPM <bsdhenrymartin@gmail.com> wrote:
>
> From: Henry Martin <bsdhenrymartin@gmail.com>
>
> smc_tcp_syn_recv_sock() gets the SMC listener through
> smc_clcsock_user_data(sk), but then dereferences it unconditionally.
>
> During concurrent teardown, sk_user_data can already be cleared while the
> hooked syn_recv_sock path is still reached, leaving smc as NULL. This
> causes a NULL pointer dereference at atomic_read(&smc->queued_smc_hs).

https://lkml.org/lkml/2026/3/11/173
