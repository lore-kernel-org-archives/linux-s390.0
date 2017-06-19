From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 4/4] s390/qeth: use diag26c to get MAC address
 on L2
Date: Mon, 19 Jun 2017 10:48:23 -0400 (EDT)
Message-ID: <20170619.104823.817601669822671550.davem@davemloft.net>
References: <20170619112225.30471-1-jwi@linux.vnet.ibm.com>
        <20170619112225.30471-5-jwi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170619112225.30471-5-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Mon, 19 Jun 2017 13:22:25 +0200

> +{
> +	struct diag26c_mac_req *request;
> +	struct diag26c_mac_resp *response;
> +	struct ccw_dev_id id;
> +	int rc;
> +

Please order local variable declarations from longest to shortest
line (reverse christmas tree).

> +	if ((request->resp_buf_len < sizeof(*response)) ||
> +	    (response->version != request->resp_version)) {

Excessive parenthesis here.

Thanks.
