From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 5/9] s390/qeth: add missing strings for IPA return codes
Date: Tue,  6 Jun 2017 14:33:46 +0200
Message-ID: <20170606123350.13781-6-jwi@linux.vnet.ibm.com>
References: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit 76b11f8e270f ("qeth: HiperSockets Network Traffic Analyzer")
missed adding the human-readable translations when adding new RCs.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_mpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index beb4bdc26de5..ab9b1376467f 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -167,6 +167,8 @@ static struct ipa_rc_msg qeth_ipa_rc_msg[] = {
 	{IPA_RC_IP_TABLE_FULL,		"Add Addr IP Table Full - ipv6"},
 	{IPA_RC_UNKNOWN_ERROR,		"IPA command failed - reason unknown"},
 	{IPA_RC_UNSUPPORTED_COMMAND,	"Command not supported"},
+	{IPA_RC_TRACE_ALREADY_ACTIVE,	"trace already active"},
+	{IPA_RC_INVALID_FORMAT,		"invalid format or length"},
 	{IPA_RC_DUP_IPV6_REMOTE, "ipv6 address already registered remote"},
 	{IPA_RC_DUP_IPV6_HOME,		"ipv6 address already registered"},
 	{IPA_RC_UNREGISTERED_ADDR,	"Address not registered"},
-- 
2.11.2
