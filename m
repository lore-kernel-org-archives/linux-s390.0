From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] s390/qeth: use kstrtobool() in
 qeth_bridgeport_hostnotification_store()
Date: Thu, 5 Oct 2017 10:22:43 +0200
Message-ID: <5c0ddbd0-0843-03e3-bceb-5422e2789623@linux.vnet.ibm.com>
References: <20171004133851.18595-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171004133851.18595-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 10/04/2017 03:38 PM, Andy Shevchenko wrote:
> The sysfs enabled value is a boolean, so kstrtobool() is a better fit
> for parsing the input string since it does the range checking for us.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Thanks Andy, queued up for our next upstream submission.
