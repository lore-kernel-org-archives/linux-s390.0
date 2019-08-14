Return-Path: <netdev-owner@vger.kernel.org>
Date: Tue, 13 Aug 2019 19:28:55 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net] s390/qeth: serialize cmd reply with concurrent
 timeout
Message-ID: <20190813192855.4d37cb89@cakuba.netronome.com>
In-Reply-To: <20190812144435.67451-1-jwi@linux.ibm.com>
References: <20190812144435.67451-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On Mon, 12 Aug 2019 16:44:35 +0200, Julian Wiedmann wrote:
> Callbacks for a cmd reply run outside the protection of card->lock, to
> allow for additional cmds to be issued & enqueued in parallel.
> 
> When qeth_send_control_data() bails out for a cmd without having
> received a reply (eg. due to timeout), its callback may concurrently be
> processing a reply that just arrived. In this case, the callback
> potentially accesses a stale reply->reply_param area that eg. was
> on-stack and has already been released.
> 
> To avoid this race, add some locking so that qeth_send_control_data()
> can (1) wait for a concurrently running callback, and (2) zap any
> pending callback that still wants to run.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied to net, thank you.

Please consider adding the Fixes tag for net submissions.
