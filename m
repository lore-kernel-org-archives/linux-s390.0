Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE82C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 30 Mar 2022 17:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbiC3ROq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244733AbiC3ROp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Mar 2022 13:14:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8559392;
        Wed, 30 Mar 2022 10:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EF74B81D6E;
        Wed, 30 Mar 2022 17:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAF6C340EC;
        Wed, 30 Mar 2022 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648660377;
        bh=NIslaD6hR1K1hA7T5NIGktk7gAw8SD895+5pJcEGgq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQ1LDkKRmaafeVvWPpJTSn+pFHzwoYqAt2Wmvqu6sDtftkrF2t/MbhU+mN1l6IhP+
         I+lGp2xSM8UPqHBDfy1fbINTv4SYhA0Jx4hxe+jfFyyD12kKRZ5yC+uLvxzgn72huS
         znvN6VEsDUHpVMPnPKbfhvOSlatJHmtARI/0AML0g7nWN6RMBQLyckUXqHLP8c3yKX
         DQ0udvf17rUYDmWiXmPGY+sBAIwB/uwk0lEvyYnNg031j+V8iNEwZtsEVv/JhF5iJv
         EWAZIhh3h3vTZQYY+vgEI1od2OetFelV0j3RpvZ7ltUc2v7W8aAXV5QZcRZI194YFf
         j6sQAp2gDdlwg==
Date:   Wed, 30 Mar 2022 10:12:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nikolay Aleksandrov <razor@blackwall.org>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        bridge@lists.linux-foundation.org,
        Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next v2] veth: Support bonding events
Message-ID: <20220330101256.53f6ef48@kernel.org>
In-Reply-To: <c512e765-f411-9305-013b-471a07e7f3ff@blackwall.org>
References: <20220329114052.237572-1-wintera@linux.ibm.com>
        <20220329175421.4a6325d9@kernel.org>
        <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org>
        <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com>
        <20220330085154.34440715@kernel.org>
        <c512e765-f411-9305-013b-471a07e7f3ff@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 30 Mar 2022 19:16:42 +0300 Nikolay Aleksandrov wrote:
> > Maybe opt-out? But assuming the event is only generated on
> > active/backup switch over - when would it be okay to ignore
> > the notification?
> 
> Let me just clarify, so I'm sure I've not misunderstood you. Do you mean opt-out as in
> make it default on? IMO that would be a problem, large scale setups would suddenly
> start propagating it to upper devices which would cause a lot of unnecessary bcast.
> I meant enable it only if needed, and only on specific ports (second part is not
> necessary, could be global, I think it's ok either way). I don't think any setup
> which has many upper vlans/macvlans would ever enable this.

That may be. I don't have a good understanding of scenarios in which
GARP is required and where it's not :) Goes without saying but the
default should follow the more common scenario.

> >> My concern was about the Hangbin's alternative proposal to notify all
> >> bridge ports. I hope in my porposal I was able to avoid infinite loops.  
> > 
> > Possibly I'm confused as to where the notification for bridge master
> > gets sent..  
> 
> IIUC it bypasses the bridge and sends a notify peers for the veth peer so it would
> generate a grat arp (inetdev_event -> NETDEV_NOTIFY_PEERS).

Ack, I was basically repeating the question of where does 
the notification with dev == br get generated.

There is a protection in this patch to make sure the other 
end of the veth is not plugged into a bridge (i.e. is not
a bridge port) but there can be a macvlan on top of that
veth that is part of a bridge, so IIUC that check is either
insufficient or unnecessary.
