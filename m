Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20BFC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 30 Mar 2022 19:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350658AbiC3TSl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351117AbiC3TSP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Mar 2022 15:18:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A4606FB
        for <linux-s390@vger.kernel.org>; Wed, 30 Mar 2022 12:16:09 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E4D93F329
        for <linux-s390@vger.kernel.org>; Wed, 30 Mar 2022 19:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648667761;
        bh=e5dkA3qH+uuDiLClm1Oo80cVgcvwun8I0S6yuR2jxQk=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=iQ7W6OMgZtu6n1x/COyYQIbMLN+F7uc4lcz4Lz1vibHByGCxltMxn5OoDyUAjhrQX
         4V9rhblz2IHwsOqjth5i0ncyjwLH/YXGpccWgZKi7OmtrOTjDuigWQ9MI1YpUCd1LC
         iuVme6tPje+eHkpGIKzVtLtoGcsFUHNfjGe67gUSZMYh9JZrR0Pxgpka3q5VYSIYF4
         kfDDuqSy2env8GEPreJHqMsLAfiu21jm8Ye2a2HFS40r5YPc2vGuIl+gjy7oLZ45zW
         g9bOKykv2LJCEpjgieSXp6opvf+wRbSn5TIgYWtQ0RumnJPCUtPgY2WS+ch7Yi81DW
         pqB3hBI65PwzA==
Received: by mail-pf1-f198.google.com with SMTP id u67-20020a627946000000b004fa6338bd77so12493800pfc.10
        for <linux-s390@vger.kernel.org>; Wed, 30 Mar 2022 12:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :comments:mime-version:content-id:content-transfer-encoding:date
         :message-id;
        bh=e5dkA3qH+uuDiLClm1Oo80cVgcvwun8I0S6yuR2jxQk=;
        b=tFuaBUHQWbfTx7bnywJyPn407Db6PiWCkyc6FR0ttx30MuS+Z7vpdLVO+QvdJ4334Y
         JLMh1Qi7cN+8CYMI2Qyj0fiW8fcV5xFwxYovx88d2GcoFc5uLdVKg23d7jXEvlJ2mQRr
         MxkJ4qvJA+OvnMp/ISh4j+UEW284owCuXCXZKlhm53mSOX81o5EeyGdTHaAKHNx7Ptbd
         ZheCQGuKN66M56Q8O266lVcOR+mbQQ5t5nknnsDng16Kqz7vH95R2+HASuchIO0KTqoY
         JD77dxiiapMYCwrggpc0TxlcbeLs04BlUGsTdtTJaiN+Q1MMz3KifU1R3kQtul8HM7oY
         +vLw==
X-Gm-Message-State: AOAM530CO/Lvxe61mfft6t3RPNTf1qLO7WaUItKaf4XiHPshV4oBn1nO
        p+8/nfDFUqkrO7TYCgva1DPsTK4+eVwX8fF8qyxFh61P5S2CB+UQggKuBnaLiuVBP2RgVCW90Uy
        56zyaIjfQbLm/Lw4gSzv6qjfVM1aeq0ZPT8q/e8s=
X-Received: by 2002:a17:903:32c9:b0:154:3a2d:fa89 with SMTP id i9-20020a17090332c900b001543a2dfa89mr1164459plr.3.1648667759763;
        Wed, 30 Mar 2022 12:15:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuVXX8rsNuKbWFBBGlsKxIr2dCQWz3o3SW1jmYCbMByPw9AKu7v0w2adSLgy27rxhwPA+bmQ==
X-Received: by 2002:a17:903:32c9:b0:154:3a2d:fa89 with SMTP id i9-20020a17090332c900b001543a2dfa89mr1164429plr.3.1648667759379;
        Wed, 30 Mar 2022 12:15:59 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id a7-20020aa79707000000b004fb17ad3aefsm19702135pfg.108.2022.03.30.12.15.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Mar 2022 12:15:58 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 378D160DD1; Wed, 30 Mar 2022 12:15:58 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 2FD1CA0B18;
        Wed, 30 Mar 2022 12:15:58 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Jakub Kicinski <kuba@kernel.org>
cc:     Nikolay Aleksandrov <razor@blackwall.org>,
        Alexandra Winter <wintera@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        bridge@lists.linux-foundation.org,
        Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v2] veth: Support bonding events
In-reply-to: <20220330101256.53f6ef48@kernel.org>
References: <20220329114052.237572-1-wintera@linux.ibm.com> <20220329175421.4a6325d9@kernel.org> <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org> <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com> <20220330085154.34440715@kernel.org> <c512e765-f411-9305-013b-471a07e7f3ff@blackwall.org> <20220330101256.53f6ef48@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Wed, 30 Mar 2022 10:12:56 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2599.1648667758.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 30 Mar 2022 12:15:58 -0700
Message-ID: <2600.1648667758@famine>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

>On Wed, 30 Mar 2022 19:16:42 +0300 Nikolay Aleksandrov wrote:
>> > Maybe opt-out? But assuming the event is only generated on
>> > active/backup switch over - when would it be okay to ignore
>> > the notification?
>> =

>> Let me just clarify, so I'm sure I've not misunderstood you. Do you mea=
n opt-out as in
>> make it default on? IMO that would be a problem, large scale setups wou=
ld suddenly
>> start propagating it to upper devices which would cause a lot of unnece=
ssary bcast.
>> I meant enable it only if needed, and only on specific ports (second pa=
rt is not
>> necessary, could be global, I think it's ok either way). I don't think =
any setup
>> which has many upper vlans/macvlans would ever enable this.
>
>That may be. I don't have a good understanding of scenarios in which
>GARP is required and where it's not :) Goes without saying but the
>default should follow the more common scenario.

	At least from the bonding failover persective, the GARP is
needed when there's a visible topology change (so peers learn the new
path), a change in MAC address, or both.  I don't think it's possible to
determine from bonding which topology changes are visible, so any
failover gets a GARP.  The original intent as best I recall was to cover
IP addresses configured on the bond itself or on VLANs above the bond.

	If I understand the original problem description correctly, the
bonding failover causes the connectivity issue because the network
segments beyond the bond interfaces don't share forwarding information
(i.e., they are completely independent).  The peer (end station or
switch) at the far end of those network segments (where they converge)
is unable to directly see that the "to bond eth0" port went down, and
has no way to know that anything is awry, and thus won't find the new
path until an ARP or forwarding entry for "veth_a2" (from the original
diagram) times out at the peer out in the network.

>> >> My concern was about the Hangbin's alternative proposal to notify al=
l
>> >> bridge ports. I hope in my porposal I was able to avoid infinite loo=
ps.  =

>> > =

>> > Possibly I'm confused as to where the notification for bridge master
>> > gets sent..  =

>> =

>> IIUC it bypasses the bridge and sends a notify peers for the veth peer =
so it would
>> generate a grat arp (inetdev_event -> NETDEV_NOTIFY_PEERS).
>
>Ack, I was basically repeating the question of where does =

>the notification with dev =3D=3D br get generated.
>
>There is a protection in this patch to make sure the other =

>end of the veth is not plugged into a bridge (i.e. is not
>a bridge port) but there can be a macvlan on top of that
>veth that is part of a bridge, so IIUC that check is either
>insufficient or unnecessary.

	I'm a bit concerned this is becoming a interface plumbing
topology change whack-a-mole.

	In the above, what if the veth is plugged into a bridge, and
there's a end station on that bridge?  If it's bridges all the way down,
where does the need for some kind of TCN mechanism stop?

	Or instead of a veth it's an physical network hop (perhaps a
tunnel; something through which notifiers do not propagate) to another
host with another bridge, then what?

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
