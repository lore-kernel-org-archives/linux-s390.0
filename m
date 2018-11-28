From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net,stable] s390/qeth: fix length check in SNMP
 processing
Date: Wed, 28 Nov 2018 11:17:33 -0800 (PST)
Message-ID: <20181128.111733.289137910908682731.davem@davemloft.net>
References: <20181128152050.36500-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181128152050.36500-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 28 Nov 2018 16:20:50 +0100

> The response for a SNMP request can consist of multiple parts, which
> the cmd callback stages into a kernel buffer until all parts have been
> received. If the callback detects that the staging buffer provides
> insufficient space, it bails out with error.
> This processing is buggy for the first part of the response - while it
> initially checks for a length of 'data_len', it later copies an
> additional amount of 'offsetof(struct qeth_snmp_cmd, data)' bytes.
> 
> Fix the calculation of 'data_len' for the first part of the response.
> This also nicely cleans up the memcpy code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable.
